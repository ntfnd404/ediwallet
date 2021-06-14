import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/date_range_entity.dart';
import '../entities/filters.dart';
import '../entities/transaction_entity.dart';
import '../repositories/preferences_repository.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions implements UseCase<List<Transaction>, TransactionParams> {
  final TransactionRepository transactionRepository;
  final PreferencesRepository preferencesRepository;
  String? _authKey;
  final String _filterSettings = Filters().toJson();

  GetTransactions(
      {required this.transactionRepository,
      required this.preferencesRepository});

  @override
  Future<Either<Failure, List<Transaction>>> call(
      TransactionParams params) async {
    _authKey = await SecureCtorage.getAuthKey();

    final DateRange _dateTimeString =
        await preferencesRepository.getDateRange();

    final String _startDate = _dateTimeString.startDate.isNotEmpty
        ? _dateTimeString.startDate
        : DateTime.now().add(const Duration(days: -7)).toString();
    final String _endDate = _dateTimeString.endDate.isNotEmpty
        ? _dateTimeString.endDate
        : DateTime.now().toString();

    return transactionRepository.getAllTransactions(
        page: params.page,
        authKey: _authKey!,
        startDate: _startDate,
        endDate: _endDate,
        filters: _filterSettings);
  }
}

class TransactionParams extends Equatable {
  final int page;

  const TransactionParams({required this.page});

  @override
  List<Object?> get props => [page];
}
