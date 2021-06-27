import 'package:bloc/bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_departments_func.dart';

class DepartmentsCubit extends Cubit<BaseState> {
  final GetDepartments getDepartmentsFunc;

  DepartmentsCubit({required this.getDepartmentsFunc}) : super(InitialState());

  Future<void> getDepartments({bool isRefresh = false}) async {
    if (state is InitialState) {
      emit(LoadingState());
      final _failureOrDepartmentsItems = await getDepartmentsFunc();

      _failureOrDepartmentsItems.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) => emit(ItemsListSuccessState(
            items: _fetchedItems, hasReachedMax: _fetchedItems.length < 30)),
      );

      return;
    }
  }
}
