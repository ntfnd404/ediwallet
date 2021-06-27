import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/bottom_loader.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transactions_list_cubit.dart';
import 'transaction_list_item.dart';

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
    return BlocConsumer<TransactionsListCubit, BaseState>(
      listener: (context, state) {
        if (state is FailureState) {
          // TODO: показываем блокирующий виджет с ошибкой но позволяем билдеру отрисовать кешированные записи
          // return const Center(child: Text('Ошибка подключения к серверу'));
        } else if (state is NoInternetConnectionState) {
          // TODO: Показать виджет с кнопкой перезапросить с сервера из-за отстусвия интернета и позволяем билдеру отрисовать кешированные записи
          showSnakBar(context, 'Нет соединения с интернетом');
        }
      },
      builder: (context, state) {
        if (state is ItemsListSuccessState<Transaction>) {
          if (state.items.isEmpty) {
            // TODO: позволяем билдеру отрисовать кешированные записи. но уведомляем снак баром
            // showSnakBar(context, 'Отсутсвуют транзакции');
            // return const Center(child: Text('Отсутсвуют транзакции'));
            // return Center(
            //   child: SizedBox(
            //     height: 25,
            //     width: 25,
            //     child: TextButton.icon(
            //       onPressed: () => _onRefresh(),
            //       icon: Image.asset(
            //         'assets/images/refresh_icon.png',
            //         fit: BoxFit.fill,
            //       ),
            //       label: const Text('Обновить'),
            //     ),
            //   ),
            // );
          }
          return RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child: state.items.isEmpty
                ? Center(
                    child: GestureDetector(
                      onTap: () => _onRefresh(),
                      child: Image.asset(
                        'assets/images/refresh_icon.png',
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemExtent: 94.0,
                    itemCount: state.hasReachedMax
                        ? state.items.length
                        : state.items.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= state.items.length) {
                        return BottomLoader();
                      } else {
                        final Transaction transaction = state.items[index];
                        return TransactionListItem(transaction: transaction);
                      }
                    },
                  ),
          );
        } else if (state is LoadingState || state is InitialState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Произошла ошибка'));
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
    BlocProvider.of<TransactionsListCubit>(context)
        .getTransactions(isRefresh: true);
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<TransactionsListCubit>(context).getTransactions();
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

  void showSnakBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
    Future.delayed(const Duration(seconds: 2));
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
