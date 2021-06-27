import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/dds_entity.dart';
import '../../domain/repositories/i_dds_repository.dart';
import '../datasources/dds_remote_datasource.dart';

class DDSRepository implements IDDSRepository {
  final DDSRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DDSRepository({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DDS>>> getDDSPaged(
      {int page = 0, required String authKey}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDDSList =
            await remoteDataSource.getAllDDS(authKey: authKey);
        return Right(remoteDDSList);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    }
    return Left(InternetConnectionFailure());
  }
}
