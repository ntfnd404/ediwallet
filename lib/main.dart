import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/secure_storage.dart';
import 'di_container.dart' as di;
import 'features/confirm/presentation/bloc/confirm_cubit.dart';
import 'features/login/presentation/bloc/login_cubit.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/pin_code/presentation/pages/pin_code_page.dart';
import 'features/transactions/presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => ConfirmCubit(),
          ),
        ],
        child: FutureBuilder(
          future: SecureCtorage.getAuthStatus(),
          builder: (BuildContext context, AsyncSnapshot<AuthStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              switch (snapshot.data) {
                case AuthStatus.pinEnabled:
                  return const PinCodePage();
                case AuthStatus.authorized:
                  return const HomePage();
                default:
                  return const LoginPage();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
