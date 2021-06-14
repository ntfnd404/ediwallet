import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:ediwallet/core/error/failure.dart';
import 'package:ediwallet/core/secure_storage.dart';
import 'package:ediwallet/core/usecases/usecase.dart';
import 'package:ediwallet/features/transactions/domain/entities/transaction_entity.dart';
import 'package:ediwallet/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';

class AddTransaction implements UseCase<Void, TransactionEntityParams> {
  final TransactionRepository transactionRepository;
  String? _authKey;

  AddTransaction({required this.transactionRepository});

  @override
  Future<Either<Failure, Void>> call(TransactionEntityParams params) async {
    _authKey = await SecureCtorage.getAuthKey();
    return transactionRepository.addTransaction(authKey: _authKey!);
  }
}

class TransactionEntityParams extends Equatable {
  final Transaction transaction;

  const TransactionEntityParams({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}
