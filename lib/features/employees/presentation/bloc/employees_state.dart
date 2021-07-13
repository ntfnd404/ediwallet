import '../../../../core/bloc/base_state.dart';
import '../../domain/entities/employee_entity.dart';

class EmployeesListSuccessState extends BaseState {
  final String employeeType;
  final bool hasReachedMax;
  final List<Employee> items;

  EmployeesListSuccessState({
    required this.employeeType,
    this.hasReachedMax = false,
    this.items = const [],
  });

  @override
  List<Object> get props => [employeeType, hasReachedMax, items];
}
