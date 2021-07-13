import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecases.dart/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/secure_storage.dart';
import '../entities/date_range_entity.dart';
import '../entities/transaction_entity.dart';
import '../repositories/i_filters_repository.dart';
import '../repositories/i_transaction_repository.dart';
import 'get_date_range.dart';

class GetTransactions implements UseCase<List<Transaction>, PagedParams> {
  final ITransactionRepository transactionRepository;
  final IFiltersRepository filtersRepository;
  final GetDateRange getDateRange;

  GetTransactions(
      {required this.getDateRange,
      required this.filtersRepository,
      required this.transactionRepository});

  @override
  Future<Either<Failure, List<Transaction>>> call(PagedParams params) async {
    final String? _authKey = await SecureCtorage.getAuthKey();
    final DateRange _dateRange = await getDateRange();
    final String _filters = filtersRepository.getJson();

    return transactionRepository.getTransactions(
        page: params.page,
        authKey: _authKey!,
        startDate: _dateRange.startDate,
        endDate: _dateRange.endDate,
        filters: _filters);
  }
}

class TransactionParams extends Equatable {
  final int page;

  const TransactionParams({required this.page});

  @override
  List<Object?> get props => [page];
}
