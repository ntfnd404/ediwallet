import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecases.dart/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../entities/employee_entity.dart';
import '../repositories/i_employees_repository.dart';

class GetEmployees implements UseCase<List<Employee>, EmployeePagedParams> {
  final IEmployeesRepository repository;
  String? _authKey;

  GetEmployees({required this.repository});

  @override
  Future<Either<Failure, List<Employee>>> call(
      EmployeePagedParams params) async {
    _authKey = await SecureCtorage.getAuthKey();
    return repository.getList(
        authKey: _authKey!,
        page: params.page,
        employeeType: params.employeeType);
  }
}

class EmployeePagedParams extends Equatable {
  final int page;
  final String employeeType;

  const EmployeePagedParams({required this.page, required this.employeeType});

  @override
  List<Object?> get props => [page, employeeType];
}
