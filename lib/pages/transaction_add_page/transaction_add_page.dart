import 'package:flutter/material.dart';

class TransactionAddPage extends StatefulWidget {
  const TransactionAddPage({Key key}) : super(key: key);

  @override
  _TransactionAddPageState createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая операция'),
      ),
      body: SafeArea(
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
                // icon: Icon(Icons.send),
                labelText: 'ДДС',
                hintText: 'Выберете ДДС',
                // helperText: 'Helper Text',
                // counterText: '0 characters',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => {
                    messenger.showSnackBar(
                        const SnackBar(content: Text('I can fly.')))
                  },
                )),
          ),
        ]),
      ),
    );
  }
}
