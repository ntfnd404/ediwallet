import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/dds_entity.dart';

abstract class IDDSRepository {
  Future<Either<Failure, List<DDS>>> getDDSPaged(
      {int page = 0, required String authKey});
}
