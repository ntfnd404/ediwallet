import 'package:bloc/bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_employees_uc.dart';
import 'employees_state.dart';

class EmployeesCubit extends Cubit<BaseState> {
  final GetEmployees getEmployeesFunc;

  EmployeesCubit({required this.getEmployeesFunc}) : super(InitialState());

  Future getItems(
      {bool isRefresh = false, String employeeType = 'Инженеры'}) async {
    final String _parsedEmployeeType = parseEmployeeType(employeeType);
    if (state is InitialState || state is FailureState) {
      emit(LoadingState());

      final _failureOrItems = await getEmployeesFunc(
          EmployeePagedParams(page: 0, employeeType: _parsedEmployeeType));

      _failureOrItems.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) => emit(EmployeesListSuccessState(
            items: _fetchedItems,
            hasReachedMax: _fetchedItems.length < 30,
            employeeType: employeeType)),
      );
    } else if (state is EmployeesListSuccessState) {
      final EmployeesListSuccessState newState =
          state as EmployeesListSuccessState;

      if (newState.hasReachedMax && isRefresh == false) {
        return;
      }

      final _failureOrItems = await getEmployeesFunc(EmployeePagedParams(
          page: isRefresh ? 0 : newState.items.length,
          employeeType: _parsedEmployeeType));

      _failureOrItems.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) {
          if (_fetchedItems.isEmpty) {
            emit(EmployeesListSuccessState(
                hasReachedMax: true, employeeType: employeeType));
            return;
          }
          if (isRefresh) {
            emit(EmployeesListSuccessState(
                items: List.of(_fetchedItems),
                hasReachedMax: _fetchedItems.length < 30 || false,
                employeeType: employeeType));
          } else {
            emit(EmployeesListSuccessState(
                items: List.of(newState.items)..addAll(_fetchedItems),
                hasReachedMax: _fetchedItems.length < 30 || false,
                employeeType: employeeType));
          }
        },
      );
    }
  }

  String parseEmployeeType(String ruEmployee) {
    switch (ruEmployee) {
      case 'Инженеры':
        return 'engeneer';
      case 'Расклейщики':
        return 'postman';
      case 'Офисные сотрудники':
        return 'employee';
      default:
        return 'engeneer';
    }
  }
}
