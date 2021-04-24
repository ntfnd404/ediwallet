import 'package:ediwallet/data/transactions_server_repository.dart';
import 'package:ediwallet/models/transaction.dart';
import 'package:flutter/material.dart';
import '../../transaction_details_page.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({
    Key key,
    @required DateTime firstDate,
    @required DateTime lastDate,
  })  : _firstDate = firstDate,
        _lastDate = lastDate,
        super(key: key);

  final DateTime _firstDate;
  final DateTime _lastDate;

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  Transactions _transactions;
  ScrollController _scrollController;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();

    _transactions = Transactions(widget._firstDate, widget._lastDate);

    refreshKey = GlobalKey<RefreshIndicatorState>();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _transactions.loadMore(
            startDate: widget._firstDate, endDate: widget._lastDate);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _transactions.stream,
        builder: (context, _snapshot) {
          if (!_snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            key: refreshKey,
            onRefresh: () =>
                _transactions.refresh(widget._firstDate, widget._lastDate),
            child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: (_snapshot.data.length as int) + 1,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  if (index < (_snapshot.data.length as num)) {
                    final Transaction transaction =
                        _snapshot.data[index] as Transaction;
                    return GestureDetector(
                      onTap: () => Navigator.push<MaterialPageRoute>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TransactionDetailsPage(transaction: transaction),
                        ),
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 70.0, child: buildListItem(transaction)),
                        ),
                      ),
                    );
                  } else {
                    if (_transactions.hasMore) {
                      return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0));
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child:
                            Center(child: Text('Отсутсвуют новые транзакции')),
                      );
                    }
                  }
                }),
          );
        });
  }

  Row buildListItem(Transaction transaction) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  '${transaction.type} \\ ${transaction.analytics}'
                      .replaceAll('', '\u{200B}'),
                  style: const TextStyle(fontSize: 18.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  '${transaction.department} \\ ${transaction.source}'
                      .replaceAll('', '\u{200B}'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  '${transaction.author} \\ ${transaction.user}'
                      .replaceAll('', '\u{200B}'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.mathSymbol} ${transaction.sum}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: transaction.mathSymbol == '+'
                        ? Colors.green
                        : Colors.red),
              ),
              Text(transaction.date),
              Text(transaction.time),
            ],
          ),
        ),
      ],
    );
  }
}
