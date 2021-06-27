import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/repositories/departments_repository.dart';
import '../datasources/department_remote_datasource.dart';

class DepartmentsRepositoryImpl implements DepartmentsRepository {
  final DepartmentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DepartmentsRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Department>>> getDepartments(
      {required String authKey}) async {
    if (await networkInfo.isConnected) {
      try {
        final _departmentsList =
            await remoteDataSource.getDepartments(authKey: authKey);
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
