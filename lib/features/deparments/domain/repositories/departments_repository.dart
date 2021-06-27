import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/department_entity.dart';

abstract class DepartmentsRepository {
  Future<Either<Failure, List<Department>>> getDepartments(
      {required String authKey});
}
