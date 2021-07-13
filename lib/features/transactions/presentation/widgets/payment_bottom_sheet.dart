import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatelessWidget {
  final Function(int?) callback;

  const PaymentBottomSheet({Key? key, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Наличные', Icons.ac_unit, callback, 0),
              _createTile(
                  context, 'Безналичные', Icons.colorize_sharp, callback, 1),
              _createTile(
                  context, 'Терминал', Icons.mobile_friendly, callback, 2),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _createTile(BuildContext context, String title, IconData icon,
      Function action, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        action.call(index);
      },
    );
  }
}
