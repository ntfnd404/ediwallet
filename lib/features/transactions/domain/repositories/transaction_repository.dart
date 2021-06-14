import 'dart:ffi';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:ediwallet/core/error/failure.dart';
import 'package:ediwallet/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, Void>> addTransaction({required String authKey});

  Future<Either<Failure, List<Transaction>>> getAllTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters});
}
