import 'package:flutter/material.dart';

class TypeOfPaymentSetings {
  void showTypePaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _createTile(context, 'Наличные', Icons.ac_unit, _action1),
                  _createTile(
                      context, 'Безналичные', Icons.colorize_sharp, _action2),
                  _createTile(
                      context, 'Терминал', Icons.mobile_friendly, _action3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ListTile _createTile(
      BuildContext context, String title, IconData icon, Function action) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  void _action1() {
    debugPrint('action1');
  }

  void _action2() {
    debugPrint('action2');
  }

  void _action3() {
    debugPrint('action3');
  }
}
