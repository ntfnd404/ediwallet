import 'package:bloc/bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/domain/usecases.dart/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/dds_entity.dart';
import '../../domain/usecases/get_dds_uc.dart';

class DDSCubit extends Cubit<BaseState> {
  final GetDDS getDDSFunc;

  DDSCubit({required this.getDDSFunc}) : super(InitialState());

  Future getDDSItems({bool isRefresh = false}) async {
    if (state is InitialState || state is FailureState) {
      emit(LoadingState());
      final _failureOrDDSItems = await getDDSFunc(const PagedParams(page: 0));

      _failureOrDDSItems.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) => emit(ItemsListSuccessState<DDS>(
            items: _fetchedItems, hasReachedMax: _fetchedItems.length < 30)),
      );
    } else if (state is ItemsListSuccessState<DDS>) {
      final ItemsListSuccessState<DDS> newState =
          state as ItemsListSuccessState<DDS>;

      if (newState.hasReachedMax && isRefresh == false) {
        return;
      }

      final _failureOrItems = await getDDSFunc(
          PagedParams(page: isRefresh ? 0 : newState.items.length));

      _failureOrItems.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) {
          if (_fetchedItems.isEmpty) {
            emit(ItemsListSuccessState<DDS>(hasReachedMax: true));
            return;
          }
          if (isRefresh) {
            emit(ItemsListSuccessState<DDS>(
                items: List.of(_fetchedItems),
                hasReachedMax: _fetchedItems.length < 30 || false));
          } else {
            emit(ItemsListSuccessState<DDS>(
                items: List.of(newState.items)..addAll(_fetchedItems),
                hasReachedMax: _fetchedItems.length < 30 || false));
          }
        },
      );
    }
  }
}
