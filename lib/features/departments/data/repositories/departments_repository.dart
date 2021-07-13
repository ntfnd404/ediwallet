import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/repositories/i_departments_repository.dart';
import '../datasources/department_remote_datasource.dart';

class DepartmentsRepository implements IDepartmentsRepository {
  final IDepartmentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DepartmentsRepository(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Department>>> getList(
      {required String authKey}) async {
    if (await networkInfo.isConnected) {
      try {
        final _departmentsList =
            await remoteDataSource.getList(authKey: authKey);
        return Right(_departmentsList);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    }
    return Left(InternetConnectionFailure());
  }
}
