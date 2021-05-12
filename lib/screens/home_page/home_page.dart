import 'package:ediwallet/blocs/accountancy_cubit/accountancy_cubit.dart';
import 'package:ediwallet/blocs/date_range_cubit/date_range_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:get_it/get_it.dart';

import 'package:ediwallet/screens/new_transaction/view/new_transaction_page.dart';
import 'package:ediwallet/screens/home_page/transactions_list/transactions_list.dart';
import 'package:ediwallet/blocs/bloc/scroll_event.dart';
import 'package:ediwallet/blocs/transactions_list_bloc/transactions_list_bloc.dart';
import 'package:ediwallet/blocs/filters_list_bloc/filters_list_bloc.dart';
import 'filters_list/widgets/filters_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DateTime _firstDate = DateTime.now().add(const Duration(days: -7));
  // DateTime _lastDate = DateTime.now();

  // TransactionsListModel get _transactionsListModel =>
  //     GetIt.I<TransactionsListModel>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => FiltersListBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              TransactionsListBloc()..add(ScrollEvent()),
        ),
        BlocProvider(
          create: (context) => AccountancyCubit()..fetchItems(),
          // lazy: true,
        ),
        BlocProvider(
          create: (context) => DaterangeCubit()..getDateTime(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          brightness: Brightness.dark,
          title: BlocBuilder<DaterangeCubit, DaterangeState>(
            builder: (context, state) {
              return Center(
                child: TextButton.icon(
                  onPressed: () {
                    showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                      initialDateRange: DateTimeRange(
                          start: state.firstDate, end: state.lastDate),
                    ).then((pikedDate) => {
                          if (pikedDate != null)
                            if (pikedDate.start != state.firstDate ||
                                pikedDate.end != state.lastDate)
                              {
                                BlocProvider.of<DaterangeCubit>(context)
                                    .setDateTime(
                                        firstDate: pikedDate.start,
                                        lastDate: pikedDate.end),
                                BlocProvider.of<AccountancyCubit>(context)
                                    .fetchItems(),
                                BlocProvider.of<TransactionsListBloc>(context)
                                    .add(ScrollEvent(isRefresh: true)),
                              }
                        });
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    "${DateFormat('dd.MM.yyyy').format(state.firstDate)} - ${DateFormat('dd.MM.yyyy').format(state.lastDate)}",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              );
            },
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
              child: BlocBuilder<AccountancyCubit, AccountancySucces>(
                builder: (context, item) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Поступления',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            item.income,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Расходы',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            item.outcome,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Касса',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            item.cash,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Задолженность',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            item.debt,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Баланс',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            item.balance,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            FiltersList(),
            const Expanded(
              child: SafeArea(
                top: false,
                child: TransactionsList(),
              ),
            )
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          items: const [
            TabItem(icon: Icons.home, title: "Home"),
            TabItem(icon: Icons.add, title: "Add"),
            TabItem(icon: Icons.settings, title: "Settings"),
          ],
          initialActiveIndex: 1,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: (int picked) => {
            if (picked == 0)
              {
                Navigator.push<MaterialPageRoute>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ),
              }
            else if (picked == 1)
              {
                Navigator.push<MaterialPageRoute>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewTransactionPage(),
                  ),
                ),
              }
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => Navigator.push<MaterialPageRoute>(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const NewTransactionPage(),
        //     ),
        //   ),
        //   child: const Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
