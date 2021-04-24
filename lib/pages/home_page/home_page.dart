import 'package:ediwallet/pages/transaction_add_page/transaction_add_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/transactions_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _firstDate;
  DateTime _lastDate;
  final List<String> filters = ['Поступления', 'Расходы'];
  int count = 0;

  @override
  void initState() {
    super.initState();

    // _getPreference().then((_storageDates) => {
    //       if (_storageDates.isNotEmpty)
    //         {
    //           _firstDate = DateTime.parse(_storageDates['firstDate']),
    //           _lastDate = DateTime.parse(_storageDates['lastDate'])
    //         }
    //       else
    //         {
    _firstDate = DateTime.now().add(const Duration(days: -7));
    _lastDate = DateTime.now();
    //     }
    // });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          brightness: Brightness.dark,
          title: TextButton.icon(
            onPressed: () {
              showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                      initialDateRange:
                          DateTimeRange(start: _firstDate, end: _lastDate))
                  .then((pikedDate) => {
                        if (pikedDate != null)
                          if (pikedDate?.start != _firstDate ||
                              pikedDate?.end != _lastDate)
                            {
                              setState(() {
                                _firstDate = pikedDate.start;
                                _lastDate = pikedDate.end;
                              }),
                              // setPreference({
                              //   'firstDate': _firstDate.toString(),
                              //   'lastDate': _lastDate.toString()
                              // })
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
              // color: Colors.purple,
              height: 50.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                        margin: const EdgeInsets.only(
                            left: 5.0, top: 10.0, right: 5.0),
                        child: InputChip(
                          label: Text(
                            filters[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                          deleteIcon: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 20,
                          ),
                          onDeleted: () => setState(() {
                            filters.remove(filters[index]);
                          }),
                        ),
                      )),
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: TransactionsList(
                  firstDate: _firstDate,
                  lastDate: _lastDate,
                ),
              ),
            )
          ],
        ),
        floatingActionButton: GestureDetector(
          onLongPress: () {},
          child: FloatingActionButton(
            onPressed: () => Navigator.push<MaterialPageRoute>(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionAddPage(),
              ),
            ),
            child: const Icon(Icons.add),
            //  async {
            // Client rnd = testClients[math.Random().nextInt(testClients.length)];
            // await DBProvider.db.newClient(rnd);
            // setState(() {});
            // },
          ),
        ),
      );

  // Widget fiterChips() => Wrap(
  //       // runSpacing: 8.0,
  //       // spacing: 8.0,
  //       children: filters
  //           .map(
  //             (filterChip) => FilterChip(
  //               label: Text(filterChip.toString()),
  //               onSelected: showSnakBar(context, 'message'),
  //             ),
  //           )
  //           .toList(),
  //     );
}

void showSnakBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
