import 'package:bloc/bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/get_transactions.dart';

class TransactionsListCubit extends Cubit<BaseState> {
  final GetTransactions getTransactionsFunc;

  TransactionsListCubit({required this.getTransactionsFunc})
      : super(InitialState());

  Future<void> getTransactions({bool isRefresh = false}) async {
    // try {
    if (state is InitialState || state is FailureState) {
      emit(LoadingState());
      final _failureOrTransactions =
          await getTransactionsFunc(const TransactionParams(page: 0));

      _failureOrTransactions.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) => emit(ItemsListSuccessState<Transaction>(
            items: _fetchedItems, hasReachedMax: _fetchedItems.length < 30)),
      );

      return;
    }

    if (state is ItemsListSuccessState<Transaction>) {
      final ItemsListSuccessState<Transaction> newState =
          state as ItemsListSuccessState<Transaction>;

      if (newState.hasReachedMax && isRefresh == false) {
        // emit(state);
        return;
      }

      final _failureOrTransactions = await getTransactionsFunc(
          TransactionParams(page: isRefresh ? 0 : newState.items.length));

      _failureOrTransactions.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) {
          if (_fetchedItems.isEmpty) {
            emit(ItemsListSuccessState<Transaction>(hasReachedMax: true));
            return;
          }
          if (isRefresh) {
            emit(ItemsListSuccessState<Transaction>(
                items: List.of(_fetchedItems),
                hasReachedMax: _fetchedItems.length < 30 || false));
          } else {
            emit(ItemsListSuccessState<Transaction>(
                items: List.of(newState.items)..addAll(_fetchedItems),
                hasReachedMax: _fetchedItems.length < 30 || false));
          }
        },
      );
    }
    // } on Exception {
    //   emit(FailureState());
    // }
  }
}
