import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../../../accountancy/presentation/bloc/accountancy_cubit.dart';
import '../bloc/filters_list_bloc/filters_cubit.dart';
import '../bloc/transactions_cubit/transactions_list_cubit.dart';
import '../widgets/accountancy_dashboard.dart';
import '../widgets/date_range.dart';
import '../widgets/filters_list.dart';
import '../widgets/transactions_list.dart';
import 'new_transaction_page.dart';

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
          create: (context) => sl<FiltersCubit>()..getFilters(),
        ),
        BlocProvider<TransactionsListCubit>(
          lazy: true,
          create: (context) => sl<TransactionsListCubit>()..getTransactions(),
        ),
        BlocProvider(
          create: (context) => sl<AccountancyCubit>()..fetchItems(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          brightness: Brightness.dark,
          title: const DateRangeWidget(),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(43, 136, 216, 1),
                Color.fromRGBO(0, 31, 120, 1)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(170.0),
              child: AccountancyDashboard()),
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
