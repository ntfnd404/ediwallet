part of 'transactions_list_cubit.dart';

class TransactionsListSuccessState extends BaseState {
  final bool hasReachedMax;
  final List<Transaction> items;

  TransactionsListSuccessState({
    this.hasReachedMax = false,
    this.items = const [],
  });

  @override
  List<Object> get props => [items, hasReachedMax];
}
