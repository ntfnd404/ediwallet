import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/employee_entity.dart';

abstract class IEmployeesRepository {
  Future<Either<Failure, List<Employee>>> getList(
      {int page = 0, required String employeeType, required String authKey});
}
