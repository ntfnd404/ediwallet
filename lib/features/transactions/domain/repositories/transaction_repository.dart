import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> addTransaction(
      {required String authKey,
      required int paymentType,
      required String sourceId,
      required String departmentId,
      required String sum});

  Future<Either<Failure, List<Transaction>>> getTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters});
}
