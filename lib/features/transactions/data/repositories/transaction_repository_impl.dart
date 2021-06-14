import 'dart:ffi';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../features/transactions/data/datasources/transaction_remote_datasource.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, Void>> addTransaction({required String authKey}) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Transaction>>> getAllTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTransactions = await remoteDataSource.getAllTransactions(
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
