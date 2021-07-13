import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../features/transactions/data/datasources/transaction_remote_datasource.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final ITransactionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepository(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addTransaction(
      {required String authKey,
      required int paymentType,
      required String sourceId,
      required String departmentId,
      required String employeeId,
      required String employeeType,
      required String sum}) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.addTransaction(
            authKey: authKey,
            paymentType: paymentType,
            sourceId: sourceId,
            departmentId: departmentId,
            employeeId: employeeId,
            employeeType: employeeType,
            sum: sum);
        return const Right(null);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    }
    return Left(InternetConnectionFailure());
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTransactions = await remoteDataSource.getTransactions(
            authKey: authKey,
            startDate: startDate,
            endDate: endDate,
            filters: filters);
        return Right(remoteTransactions);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    }
    return Left(InternetConnectionFailure());
  }
}
