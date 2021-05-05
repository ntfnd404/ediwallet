import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ediwallet/common/bloc/scroll_event.dart';
import 'package:ediwallet/common/bloc/scroll_state.dart';
import 'package:ediwallet/common/widgets/bottom_loader.dart';
import 'package:ediwallet/transaction_page/widgets/transaction_list_item.dart';
import 'package:ediwallet/transaction_page/bloc/transaction_bloc.dart';
import 'package:ediwallet/transaction_page/models/transaction.dart';
import 'package:ediwallet/pages/transaction_details_page.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final _scrollController = ScrollController();
  late TransactionBloc _transactionBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _transactionBloc = context.read<TransactionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, ScrollState<Transaction>>(
      builder: (context, state) {
        switch (state.status) {
          case StateStatus.failure:
            return const Center(child: Text('Ошибка подключения к серверу'));
          case StateStatus.success:
            if (state.items.isEmpty) {
              return const Center(child: Text('Нет новых элементов списка'));
            }
            return RefreshIndicator(
              onRefresh: () => _onRefresh(),
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.hasReachedMax
                    ? state.items.length
                    : state.items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  final Transaction transaction = state.items[index];
                  return index >= state.items.length
                      ? BottomLoader()
                      : GestureDetector(
                          onTap: () => Navigator.push<MaterialPageRoute>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionDetailsPage(
                                      transaction: transaction),
                                ),
                              ),
                          child: TransactionListItem(transaction: transaction));
                },
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  //itemCount: state.hasReachedMax ? state.items.length : state.items.length + 1,

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _transactionBloc.add(ScrollEvent(isRefresh: true));
  }

  void _onScroll() {
    if (_isBottom) _transactionBloc.add(ScrollEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
