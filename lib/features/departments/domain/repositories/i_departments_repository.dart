import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/department_entity.dart';

abstract class IDepartmentsRepository {
  Future<Either<Failure, List<Department>>> getList({required String authKey});
}
