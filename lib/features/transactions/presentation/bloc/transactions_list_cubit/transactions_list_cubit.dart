import 'package:bloc/bloc.dart';

import '../../../../../core/bloc/base_state.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/get_transactions.dart';

part 'transactions_list_state.dart';

class TransactionsListCubit extends Cubit<BaseState> {
  final GetTransactions getTransactionsFunc;

  TransactionsListCubit({required this.getTransactionsFunc})
      : super(InitialState());

  Future<void> getTransactions({bool isRefresh = false}) async {
    // try {
    if (state is InitialState) {
      emit(LoadingState());
      final _failureOrTransactions =
          await getTransactionsFunc(const TransactionParams(page: 0));

      _failureOrTransactions.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) => emit(TransactionsListSuccessState(
            items: _fetchedItems, hasReachedMax: _fetchedItems.length < 30)),
      );

      return;
    }

    if (state is TransactionsListSuccessState) {
      final TransactionsListSuccessState newState =
          state as TransactionsListSuccessState;

      if (newState.hasReachedMax) {
        emit(state);
        return;
      }

      final _failureOrTransactions = await getTransactionsFunc(
          TransactionParams(page: newState.items.length));

      _failureOrTransactions.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) {
          if (_fetchedItems.isEmpty) {
            emit(TransactionsListSuccessState(hasReachedMax: true));
            return;
          }
          emit(TransactionsListSuccessState(
              items: List.of(newState.items)..addAll(_fetchedItems),
              hasReachedMax: _fetchedItems.length < 30 || false));
        },
      );
    }
    // } on Exception {
    //   emit(FailureState());
    // }
  }
}
