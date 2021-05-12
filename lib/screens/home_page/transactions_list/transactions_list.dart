import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ediwallet/screens/home_page/transactions_list/transaction_list_item.dart';
import 'package:ediwallet/models/transaction.dart';
import 'package:ediwallet/screens/transaction_details_page/transaction_details_page.dart';
import 'package:ediwallet/blocs/scroll_state.dart';
import 'package:ediwallet/blocs/transactions_list_bloc/transactions_list_bloc.dart';
import 'package:ediwallet/blocs/bloc/scroll_event.dart';
import 'package:ediwallet/common/bottom_loader.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsListBloc, ScrollState<Transaction>>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case StateStatus.failure:
            return const Center(child: Text('Ошибка подключения к серверу'));
          case StateStatus.success:
            if (state.items.isEmpty) {
              return const Center(child: Text('Нет новых элементов списка'));
            }
            return RefreshIndicator(
              onRefresh: () => _onRefresh(),
              // TODO: хуяк и заметка
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.items.length,
                // TODO: сделать что нибудь
                // itemCount: state.hasReachedMax
                //     ? state.items.length
                //     : state.items.length + 1,
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<TransactionsListBloc>(context)
        .add(ScrollEvent(isRefresh: true));
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<TransactionsListBloc>(context).add(ScrollEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    // final maxScroll = _scrollController.position.maxScrollExtent;
    // final currentScroll = _scrollController.offset;
    // return currentScroll >= (maxScroll * 0.9);
    return _scrollController.position.maxScrollExtent ==
        _scrollController.offset;
  }
}
