import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../di_container.dart';
import '../../../../accountancy/presentation/bloc/accountancy_cubit.dart';
import '../../bloc/date_range_cubit/date_range_cubit.dart';
import '../../bloc/filters_list_bloc/filters_list_bloc.dart';
import '../../bloc/transactions_list_cubit/transactions_list_cubit.dart';
import '../../widgets/filters_list.dart';
import '../../widgets/transactions_list.dart';
import '../new_transaction_page/new_transaction_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => FiltersListBloc(),
        ),
        BlocProvider<TransactionsListCubit>(
          lazy: true,
          create: (BuildContext context) =>
              sl<TransactionsListCubit>()..getTransactions(),
        ),
        BlocProvider(
          create: (context) => AccountancyCubit()..fetchItems(),
        ),
        BlocProvider(
          create: (context) => sl<DateRangeCubit>()..getDateTime(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          brightness: Brightness.dark,
          title: BlocBuilder<DateRangeCubit, DateRangeState>(
            builder: (context, state) {
              return TextButton.icon(
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
                              BlocProvider.of<DateRangeCubit>(context)
                                  .setDateTime(
                                      firstDate: pikedDate.start,
                                      lastDate: pikedDate.end),
                              BlocProvider.of<AccountancyCubit>(context)
                                  .fetchItems(),
                              BlocProvider.of<TransactionsListCubit>(context)
                                  .getTransactions(isRefresh: true),
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
          bottom: buildAccountancyDashboard(),
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

  PreferredSize buildAccountancyDashboard() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        // TODO: переделать на FutureBuilder внутри BlocBuilder
        child: BlocBuilder<AccountancyCubit, AccountancySucces>(
          builder: (context, item) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Поступления',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      item.income,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
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
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      item.outcome,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
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
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      item.cash,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
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
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      item.debt,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
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
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      item.balance,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
