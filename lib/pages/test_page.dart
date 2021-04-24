// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TestPage extends StatefulWidget {
//   TestPage({Key key}) : super(key: key);

//   @override
//   _TestPageState createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   DateTime _firstDate;
//   DateTime _lastDate;

//   @override
//   void initState() {
//     super.initState();

//     _firstDate = DateTime.now().add(Duration(days: -7));
//     _lastDate = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           // centerTitle: true,
//           brightness: Brightness.dark,
//           title: TextButton.icon(
//             onPressed: () {
//               showDateRangePicker(
//                       context: context,
//                       firstDate: new DateTime(DateTime.now().year - 5),
//                       lastDate: new DateTime(DateTime.now().year + 5),
//                       initialDateRange:
//                           DateTimeRange(start: _firstDate, end: _lastDate))
//                   .then((pikedDate) => {
//                         if (pikedDate != null)
//                           if (pikedDate?.start != _firstDate ||
//                               pikedDate?.end != _lastDate)
//                             {
//                               setState(() {
//                                 _firstDate = pikedDate.start;
//                                 _lastDate = pikedDate.end;
//                               }),
//                               // setPreference({
//                               //   'firstDate': _firstDate.toString(),
//                               //   'lastDate': _lastDate.toString()
//                               // })
//                             }
//                       });
//             },
//             icon: Icon(
//               Icons.calendar_today_outlined,
//               color: Colors.white,
//             ),
//             label: Text(
//               "${DateFormat('dd.MM.yyyy').format(_firstDate)} - ${DateFormat('dd.MM.yyyy').format(_lastDate)}",
//               style: TextStyle(fontSize: 16.0),
//             ),
//             style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//             ),
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 Color.fromRGBO(43, 136, 216, 1),
//                 Color.fromRGBO(0, 31, 120, 1)
//               ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//             ),
//           ),
//           bottom: PreferredSize(
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         const Text(
//                           "Поступления",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                         Text(
//                           "55000",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.white,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         const Text(
//                           "Расходы",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                         Text(
//                           "55444",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.white,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         const Text(
//                           "Касса",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                         Text(
//                           "55444",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.white,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         const Text(
//                           "Задолженность",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                         Text(
//                           "55444",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.white,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         const Text(
//                           "Баланс",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                         Text(
//                           "76000",
//                           style: TextStyle(color: Colors.white, fontSize: 15.0),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               preferredSize: Size.fromHeight(170.0)),
//         ),
//         body: Column(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.width / 1.35,
//                   decoration: BoxDecoration(
//                     // borderRadius: BorderRadius.circular(25.0),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black26,
//                           offset: Offset(0.0, 2.0),
//                           blurRadius: 6.0),
//                     ],
//                     gradient: new LinearGradient(colors: [
//                       Color.fromRGBO(43, 136, 216, 1),
//                       Color.fromRGBO(0, 31, 120, 1)
//                     ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//                   ),
//                 ),
//                 SafeArea(
//                   bottom: false,
//                   child: Column(
//                     children: <Widget>[
//                       Align(
//                         alignment: Alignment.topCenter,
//                         child: TextButton.icon(
//                           onPressed: () {
//                             showDateRangePicker(
//                                     context: context,
//                                     firstDate:
//                                         new DateTime(DateTime.now().year - 5),
//                                     lastDate:
//                                         new DateTime(DateTime.now().year + 5),
//                                     initialDateRange: DateTimeRange(
//                                         start: _firstDate, end: _lastDate))
//                                 .then((pikedDate) => {
//                                       if (pikedDate != null)
//                                         if (pikedDate?.start != _firstDate ||
//                                             pikedDate?.end != _lastDate)
//                                           {
//                                             setState(() {
//                                               _firstDate = pikedDate.start;
//                                               _lastDate = pikedDate.end;
//                                             }),
//                                             setPreference({
//                                               'firstDate':
//                                                   _firstDate.toString(),
//                                               'lastDate': _lastDate.toString()
//                                             })
//                                           }
//                                     });
//                           },
//                           icon: Icon(
//                             Icons.calendar_today,
//                             color: Colors.white,
//                           ),
//                           label: Text(
//                               "${DateFormat('dd.MM.yyyy').format(_firstDate)} - ${DateFormat('dd.MM.yyyy').format(_lastDate)}"),
//                           style: ButtonStyle(
//                             foregroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20.0, vertical: 10.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Text(
//                                   "Поступления",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                                 Text(
//                                   "55000",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                               ],
//                             ),
//                             Divider(
//                               color: Colors.white,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Text(
//                                   "Расходы",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                                 Text(
//                                   "55444",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                               ],
//                             ),
//                             Divider(
//                               color: Colors.white,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Text(
//                                   "Касса",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                                 Text(
//                                   "55444",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                               ],
//                             ),
//                             Divider(
//                               color: Colors.white,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Text(
//                                   "Задолженность",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                                 Text(
//                                   "55444",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                               ],
//                             ),
//                             Divider(
//                               color: Colors.white,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Text(
//                                   "Баланс",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                                 Text(
//                                   "76000",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15.0),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               // color: Colors.purple,
//               height: 40.0,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: filters.length,
//                   itemBuilder: (BuildContext context, int index) => Container(
//                         margin:
//                             EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
//                         child: InputChip(
//                           label: Text(
//                             filters[index],
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           backgroundColor: Theme.of(context).primaryColor,
//                           deleteIcon: Icon(
//                             Icons.cancel,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                           onDeleted: () => setState(() {
//                             filters.remove(filters[index]);
//                           }),
//                         ),
//                       )),
//             ),
//             Expanded(
//               child: SafeArea(
//                 minimum: EdgeInsets.only(top: 10.0),
//                 top: false,
//                 child: TransactionsList(
//                   firstDate: _firstDate,
//                   lastDate: _lastDate,
//                 ),
//               ),
//             )
//           ],
//         ),,
//       );
// }
