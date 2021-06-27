import 'package:flutter/material.dart';

import '../../domain/entities/transaction_entity.dart';
import '../pages/transaction_details_page.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      child: Container(
        height: 86.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 2))
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    TransactionDetailsPage(transaction: transaction),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
        ),
      ),
    );
  }
}
