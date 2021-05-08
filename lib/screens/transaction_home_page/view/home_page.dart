import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:get_it/get_it.dart';

import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filters_event.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filtes_list_bloc.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/filters_list.dart';
import 'package:ediwallet/screens/new_transaction/view/new_transaction_page.dart';
import 'package:ediwallet/screens/transaction_home_page/bloc/scroll_event.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/transactions_list/bloc/transactions_list_bloc.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/transactions_list/transactions_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _firstDate = DateTime.now().add(const Duration(days: -7));
  DateTime _lastDate = DateTime.now();

  // TransactionsListModel get _transactionsListModel =>
  //     GetIt.I<TransactionsListModel>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          brightness: Brightness.dark,
          title: Center(
            child: TextButton.icon(
              onPressed: () {
                showDateRangePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
                        initialDateRange: DateTimeRange(
                            start: DateTime.now().add(const Duration(days: -7)),
                            end: DateTime.now()))
                    .then((pikedDate) => {
                          if (pikedDate != null)
                            if (pikedDate.start != _firstDate ||
                                pikedDate.end != _lastDate)
                              {
                                setState(() {
                                  _firstDate = pikedDate.start;
                                  _lastDate = pikedDate.end;

                                  // BlocProvider.of<TransactionsListBloc>(context)
                                  //     .add(
                                  //   ScrollEvent(
                                  //     isRefresh: true,
                                  //     firstDate: pikedDate.start,
                                  //     lastDate: pikedDate.end,
                                  //     filterSettings: _filtersBar.toJson(),
                                  //   ),
                                  // );
                                }),
                              }
                        });
              },
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
              ),
              label: Text(
                "${DateFormat('dd.MM.yyyy').format(_firstDate)} - ${DateFormat('dd.MM.yyyy').format(_lastDate)}",
                style: const TextStyle(fontSize: 16.0),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Поступления',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        '55000',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Расходы',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        '55444',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Касса',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        '55444',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Задолженность',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        '55444',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Баланс',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        '76000',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
              child: BlocProvider<FiltersListBloc>(
                // lazy: false,
                create: (BuildContext context) {
                  return FiltersListBloc()
                    ..add(
                      FiltersEvent(
                          // filterSettings: _filtersBar.toJson(),
                          ),
                    );
                },
                child: const FiltersList(),
              ),
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: BlocProvider(
                  create: (BuildContext context) {
                    return TransactionsListBloc()
                      ..add(
                        ScrollEvent(
                            // filterSettings: _filtersBar.toJson(),
                            ),
                      );
                  },
                  child: const TransactionsList(),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push<MaterialPageRoute>(
            context,
            MaterialPageRoute(
              builder: (context) => const NewTransactionPage(),
            ),
          ),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}
