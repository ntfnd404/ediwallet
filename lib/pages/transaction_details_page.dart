import 'package:ediwallet/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionDetailsPage extends StatefulWidget {
  const TransactionDetailsPage({Key key, this.transaction}) : super(key: key);
  final Transaction transaction;

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          '${widget.transaction.date} ${widget.transaction.time}',
          style: const TextStyle(fontSize: 20.0),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(43, 136, 216, 1),
              Color.fromRGBO(0, 31, 120, 1)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(170.0),
          child: Center(
            heightFactor: 3.0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                '${widget.transaction.mathSymbol}${widget.transaction.sum}',
                style: TextStyle(
                    fontSize: 50.0,
                    color: widget.transaction.mathSymbol == '+'
                        ? Colors.green
                        : Colors.red),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              children: [
                // BorderedText(),
                // TextField(
                //   decoration: InputDecoration(
                //       hintText: "Тип оплаты",
                //       labelText: "tttt",
                //       // labelStyle: TextStyle(fontSize: 20.0),
                //       border: OutlineInputBorder()),
                //   obscureText: true,
                //   // "Тип оплаты:",
                // ),
                const TextField(
                  // enabled: false
                  readOnly: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.send),
                    hintText: 'Hint Text',
                    helperText: 'Helper Text',
                    counterText: '0 characters',
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.transaction.type,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Пользователь:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      widget.transaction.user,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'ДДС:',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Text(
                      widget.transaction.source,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Отдел:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      widget.transaction.department,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Автор:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      widget.transaction.author,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
