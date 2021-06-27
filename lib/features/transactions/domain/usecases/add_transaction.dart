import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/transaction_repository.dart';

class AddTransaction implements UseCase<void, AddTransactionEntityParams> {
  final TransactionRepository transactionRepository;
  String? _authKey;

  AddTransaction({required this.transactionRepository});

  @override
  Future<Either<Failure, void>> call(AddTransactionEntityParams params) async {
    _authKey = await SecureCtorage.getAuthKey();
    return transactionRepository.addTransaction(
        authKey: _authKey!,
        paymentType: params.paymentType,
        sourceId: params.sourceId,
        departmentId: params.departmentId,
        sum: params.sum);
  }
}

class AddTransactionEntityParams extends Equatable {
  final int paymentType;
  final String sourceId;
  final String departmentId;
  final String sum;

  const AddTransactionEntityParams(
      {required this.paymentType,
      required this.sourceId,
      required this.departmentId,
      required this.sum});

  @override
  List<Object?> get props => [paymentType, sourceId, departmentId, sum];
}
