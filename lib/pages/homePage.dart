import 'dart:convert';
import 'package:ediwallet/common/fakeTransactionsReposytory.dart';
import 'package:ediwallet/pages/transactionDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ediwallet/models/Transaction.dart';
import 'package:ediwallet/common/parser.dart' as parser;
import 'package:ediwallet/common/httpService.dart' as httpService;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _firstDate;
  DateTime _lastDate;
  ScrollController _scrollController;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    _firstDate = DateTime.now();
    _lastDate = DateTime.now().add(Duration(days: 7));
    _scrollController = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchFromServer(false);
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
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
                                  firstDate:
                                      new DateTime(DateTime.now().year - 5),
                                  lastDate:
                                      new DateTime(DateTime.now().year + 5),
                                  initialDateRange: DateTimeRange(
                                      start: _firstDate, end: _lastDate))
                              .then((pikedDate) => {
                                    if (pikedDate != null)
                                      if (pikedDate?.start != _firstDate ||
                                          pikedDate?.end != _lastDate)
                                        {
                                          setState(() {
                                            _firstDate = pikedDate.start;
                                            _lastDate = pikedDate.end;
                                          })
                                        }
                                  });
                        },
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        label: Text(
                            "${DateFormat('dd.MM.yyyy').format(_firstDate)} - ${DateFormat('dd.MM.yyyy').format(_lastDate)}"),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Поступления",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Text(
                                "55000",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Text(
                                "55444",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Text(
                                "55444",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Text(
                                "55444",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Text(
                                "76000",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
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
          Container(
            // color: Colors.purple,
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                'Все',
                'Поступления',
                'Расходы',
                'Касса',
                'Долг',
                'Баланс'
              ]
                  .map((e) => Container(
                        color: Colors.pink,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        child: OutlineButton(
                          child: Text(e),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            showSnakBar(context, "Filter pressed");
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: RefreshIndicator(
                key: refreshKey,
                child: ListView.separated(
                    controller: _scrollController,
                    addAutomaticKeepAlives: false,
                    itemCount: transactions.length,
                    padding: EdgeInsets.all(10),
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TransactionDetailsPage(transaction))),
                        child: Container(
                          color: Colors.deepPurple,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 250.0,
                                    child: Text(
                                      '${transaction.type} \\ ${transaction.user}',
                                      style: TextStyle(fontSize: 18.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    width: 250.0,
                                    child: Text(
                                      '${transaction.department} \\ ${transaction.source}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    width: 250.0,
                                    child: Text(
                                      '${transaction.author} \\ ${transaction.department}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    transaction.mathSymbol +
                                        " " +
                                        transaction.sum.toString(),
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: transaction.mathSymbol == "+"
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                  Text(transaction.date),
                                  Text(transaction.time)
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                onRefresh: () => fetchFromServer(true),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // Client rnd = testClients[math.Random().nextInt(testClients.length)];
          // await DBProvider.db.newClient(rnd);
          // setState(() {});
        },
      ),
    );
  }

  Future fetchFromServer(bool _refresh) async {
    refreshKey.currentState?.show(atTop: false);
    bool refresh = _refresh ?? false;
    var responce =
        await httpService.fetchFromServer("bookkeeping/pays", '{"path":"re"}');

    if (responce.statusCode == 200) {
      List<Transaction> apiItems =
          parser.transactions(utf8.decode(responce.bodyBytes));

      setState(() {
        if (refresh) {
          transactions.clear();
        }
        apiItems.forEach((element) {
          transactions.add(element);
        });
      });
    } else {
      showSnakBar(context, "Ошибка получения данных с сервера");
    }
  }
}

showSnakBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
