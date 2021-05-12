import 'package:ediwallet/screens/confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

// import 'package:ediwallet/screens/home_page/home_page.dart';
import 'package:ediwallet/screens/login_page.dart';
import 'package:ediwallet/blocs/login_cubit/login_cubit.dart';
// import 'data/transactions_list_model.dart';

GetIt getIt = GetIt.instance;

void main() {
  // getIt.registerLazySingleton<TransactionsListModel>(
  //     () => TransactionsListModel());

  runApp(App());
}

// if (Platform.isAndroid) {
//   // Android-specific code
// } else if (Platform.isIOS) {
//   // iOS-specific code
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edi wallet',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: const ConfirmPage(
            verificationCode: '2423', base64LoginPassword: 'rrr'),
      ),
    );
  }
}
