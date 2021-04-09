import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edi wallet',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(title: 'Flutter Home Page 90'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width / 1.5,
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
              child: Align(
                alignment: Alignment.topCenter,
                child: TextButton.icon(
                  onPressed: () {
                    print("Clicked!!!2");
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  label: Text("11.02.2021 - 31.02.2021"),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                ),
                // child: Opacity(
                //     opacity: 1,
                //     child: ElevatedButton.icon(
                //       onPressed: () {
                //         print("Clicked!!!");
                //       },
                //       icon: Icon(
                //         Icons.calendar_today,
                //         color: Colors.white,
                //       ),
                //       label: Text("Test"),
                //     )),
              ),
            )
          ])
        ],
      ),
    );
  }
}
