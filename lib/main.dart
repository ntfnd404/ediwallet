import 'package:flutter/material.dart';
import 'package:ediwallet/pages/home_page/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

// import 'data/transactions_list_model.dart';

GetIt getIt = GetIt.instance;

void main() {
  // getIt.registerLazySingleton<TransactionsListModel>(
  //     () => TransactionsListModel());

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edi wallet',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('ru')],
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const HomePage(),
    );
  }
}
