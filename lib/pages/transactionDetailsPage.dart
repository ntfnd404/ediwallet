import 'package:ediwallet/models/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage(this.transaction, {Key key}) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    DateTime _firstDate;
    DateTime _lastDate;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 1.35,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0),
                  ],
                  gradient: new LinearGradient(colors: [
                    Color.fromRGBO(43, 136, 216, 1),
                    Color.fromRGBO(0, 31, 120, 1)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
            ],
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: TextButton.icon(
                    onPressed: () {
                      showDateRangePicker(
                              context: context,
                              firstDate: new DateTime(DateTime.now().year - 5),
                              lastDate: new DateTime(DateTime.now().year + 5),
                              initialDateRange: DateTimeRange(
                                  start: _firstDate, end: _lastDate))
                          .then((pikedDate) => {
                                if (pikedDate != null)
                                  if (pikedDate?.start != _firstDate ||
                                      pikedDate?.end != _lastDate)
                                    {
                                      // setState(() {
                                      //   _firstDate = pikedDate.start;
                                      //   _lastDate = pikedDate.end;
                                      // })
                                    }
                              });
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    label: Text("tt"),
                    // "${DateFormat('dd.MM.yyyy').format(_firstDate)} - ${DateFormat('dd.MM.yyyy').format(_lastDate)}"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Поступления",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "55000",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Расходы",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "55444",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Касса",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "55444",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Задолженность",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "55444",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Баланс",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "76000",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
