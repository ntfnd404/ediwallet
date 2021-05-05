// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import 'package:ediwallet/data/transactions_list_model.dart';
// import 'package:ediwallet/models/filter_chip.dart';
// import 'package:ediwallet/models/filters_bar.dart';
// import 'package:ediwallet/transaction/models/transaction.dart';
// import 'package:ediwallet/new_transaction/view/new_transaction_page.dart';
// import 'package:ediwallet/pages/transaction_details_page.dart';
// import 'package:ediwallet/pages/type_of_payment_settings.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   DateTime _firstDate = DateTime.now().add(const Duration(days: -7));
//   DateTime _lastDate = DateTime.now();
//   late TypeOfPaymentSetings _paymentSettings;

//   TransactionsListModel get _transactionsListModel =>
//       GetIt.I<TransactionsListModel>();
//   final ScrollController _scrollController = ScrollController();
//   late GlobalKey<RefreshIndicatorState> refreshKey;
//   late FiltersBar _filtersBar;
//   int count = 0;

//   @override
//   void initState() {
//     super.initState();

//     _filtersBar = FiltersBar();
//     _paymentSettings = TypeOfPaymentSetings();

//     _transactionsListModel.refresh(_firstDate, _lastDate, _filtersBar.toJson());

//     refreshKey = GlobalKey<RefreshIndicatorState>();

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         _transactionsListModel.loadMore(
//             startDate: _firstDate, endDate: _lastDate, filters: '');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           // centerTitle: true,
//           brightness: Brightness.dark,
//           title: Center(
//             child: TextButton.icon(
//               onPressed: () {
//                 showDateRangePicker(
//                         context: context,
//                         firstDate: DateTime(DateTime.now().year - 5),
//                         lastDate: DateTime(DateTime.now().year + 5),
//                         initialDateRange:
//                             DateTimeRange(start: _firstDate, end: _lastDate))
//                     .then((pikedDate) => {
//                           if (pikedDate != null)
//                             if (pikedDate.start != _firstDate ||
//                                 pikedDate.end != _lastDate)
//                               {
//                                 setState(() {
//                                   _firstDate = pikedDate.start;
//                                   _lastDate = pikedDate.end;
//                                   _transactionsListModel.refresh(_firstDate,
//                                       _lastDate, _filtersBar.toJson());
//                                 }),
//                               }
//                         });
//               },
//               icon: const Icon(
//                 Icons.calendar_today_outlined,
//                 color: Colors.white,
//               ),
//               label: Text(
//                 "${DateFormat('dd.MM.yyyy').format(_firstDate)} - ${DateFormat('dd.MM.yyyy').format(_lastDate)}",
//                 style: const TextStyle(fontSize: 16.0),
//               ),
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               ),
//             ),
//           ),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 Color.fromRGBO(43, 136, 216, 1),
//                 Color.fromRGBO(0, 31, 120, 1)
//               ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//             ),
//           ),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(170.0),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const <Widget>[
//                       Text(
//                         'Поступления',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                       Text(
//                         '55000',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     color: Colors.white,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const <Widget>[
//                       Text(
//                         'Расходы',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                       Text(
//                         '55444',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     color: Colors.white,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const <Widget>[
//                       Text(
//                         'Касса',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                       Text(
//                         '55444',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     color: Colors.white,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const <Widget>[
//                       Text(
//                         'Задолженность',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                       Text(
//                         '55444',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     color: Colors.white,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const <Widget>[
//                       Text(
//                         'Баланс',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                       Text(
//                         '76000',
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: ChangeNotifierProvider(
//           create: (BuildContext context) => _filtersBar,
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 // color: Colors.purple,
//                 height: 50.0,
//                 child: buildFiltersListView(),
//               ),
//               Expanded(
//                 child: SafeArea(
//                   top: false,
//                   child: buildTransactionsStreamBuilder(),
//                 ),
//               )
//             ],
//           ),
//         ),
//         floatingActionButton: GestureDetector(
//           onLongPress: () {},
//           child: FloatingActionButton(
//             onPressed: () => Navigator.push<MaterialPageRoute>(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const NewTransactionPage(),
//               ),
//             ),
//             child: const Icon(Icons.add),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       );

//   StreamBuilder<List<Transaction>> buildTransactionsStreamBuilder() {
//     return StreamBuilder(
//         stream: _transactionsListModel.stream,
//         builder: (context, _snapshot) {
//           if (!_snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return RefreshIndicator(
//             // key: refreshKey,
//             onRefresh: () => _transactionsListModel.refresh(
//                 _firstDate, _lastDate, _filtersBar.toJson()),
//             child: ListView.builder(
//                 controller: _scrollController,
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 itemCount: (_snapshot.data!.length) + 1,
//                 padding: const EdgeInsets.all(10.0),
//                 itemBuilder: (context, index) {
//                   if (index < _snapshot.data!.length) {
//                     final Transaction transaction = _snapshot.data![index];
//                     return GestureDetector(
//                       onTap: () => Navigator.push<MaterialPageRoute>(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               TransactionDetailsPage(transaction: transaction),
//                         ),
//                       ),
//                       child: Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             height: 70.0,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Flexible(
//                                         child: Text(
//                                           '${transaction.type} \\ ${transaction.analytics}'
//                                               .replaceAll('', '\u{200B}'),
//                                           style:
//                                               const TextStyle(fontSize: 18.0),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           '${transaction.department} \\ ${transaction.source}'
//                                               .replaceAll('', '\u{200B}'),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           '${transaction.author} \\ ${transaction.user}'
//                                               .replaceAll('', '\u{200B}'),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 100,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         '${transaction.mathSymbol} ${transaction.sum}',
//                                         style: TextStyle(
//                                             fontSize: 18.0,
//                                             color: transaction.mathSymbol == '+'
//                                                 ? Colors.green
//                                                 : Colors.red),
//                                       ),
//                                       Text(transaction.date),
//                                       Text(transaction.time),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   } else {
//                     if (_transactionsListModel.hasMore) {
//                       return const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 32.0));
//                     } else {
//                       return const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 32.0),
//                         child:
//                             Center(child: Text('Отсутсвуют новые транзакции')),
//                       );
//                     }
//                   }
//                 }),
//           );
//         });
//   }

//   ListView buildFiltersListView() {
//     return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _filtersBar.items.length,
//         itemBuilder: (BuildContext context, int index) {
//           final FilterChipData currentFilter = _filtersBar.items[index];
//           return Container(
//             margin: const EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
//             child: FilterChip(
//                 selected: currentFilter.isSelected,
//                 disabledColor: Theme.of(context).primaryColor,
//                 label: Text(currentFilter.name),
//                 onSelected: (bool selected) {
//                   if (index == 0) {
//                     if (selected == false &&
//                         _filtersBar.items[1].isSelected == false) {
//                       showSnakBar(context,
//                           'Один из фильтров вида поступления должен быть выбран');
//                       return;
//                     }
//                   } else if (index == 1) {
//                     if (selected == false &&
//                         _filtersBar.items[0].isSelected == false) {
//                       showSnakBar(context,
//                           'Один из фильтров вида поступления должен быть выбран');
//                       return;
//                     }
//                   } else {
//                     _paymentSettings.showTypePaymentBottomSheet(context);
//                   }
//                   setState(() {
//                     _filtersBar.changeItem(index);

//                     // final counter = context.read<FiltersBar>();
//                     // counter.changeItem(index);
//                     _transactionsListModel.refresh(
//                         _firstDate, _lastDate, _filtersBar.toJson());
//                   });
//                 }),
//           );
//         });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

// void showSnakBar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//     ),
//   );
//   Future.delayed(const Duration(seconds: 2));
//   ScaffoldMessenger.of(context).hideCurrentSnackBar();
// }
