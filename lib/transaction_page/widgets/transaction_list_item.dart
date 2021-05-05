import 'package:flutter/material.dart';
import 'package:ediwallet/transaction_page/models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 70.0,
          child: Row(
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
          ),
        ),
      ),
    );
  }
}
