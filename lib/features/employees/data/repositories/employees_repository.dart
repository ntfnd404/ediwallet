import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/i_employees_repository.dart';
import '../datasources/employees_remote_datasource.dart';

class EmployeesRepository implements IEmployeesRepository {
  final IEmployeesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EmployeesRepository(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Employee>>> getList(
      {int page = 0,
      required String employeeType,
      required String authKey}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployeesList = await remoteDataSource.getList(
            page: page, employeeType: employeeType, authKey: authKey);
        return Right(remoteEmployeesList);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    }
    return Left(InternetConnectionFailure());
  }
}
