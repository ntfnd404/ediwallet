import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../confirm/presentation/bloc/confirm_cubit.dart';
import '../../../confirm/presentation/pages/confirm_page.dart';
import '../bloc/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(232, 235, 245, 1.0),
            Color.fromRGBO(251, 252, 255, 1.0)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 132.0, left: 24.0, right: 24.0),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 144.0,
                    height: 144.0,
                    child: Image.asset(
                      'assets/images/ic_phone_password_144.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 48.0),
                  child: Text(
                    'Введите логин и пароль',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: _loginController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.purple),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Логин',
                    labelText: 'Логин',
                  ),
                ),
                const SizedBox(height: 24.0),
                TextField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onLongPress: () {
                        setState(() => _passwordVisible = true);
                      },
                      onLongPressUp: () {
                        setState(() => _passwordVisible = false);
                      },
                      child: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.purple),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Пароль',
                    labelText: 'Пароль',
                  ),
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.error.isEmpty) {
                      Navigator.of(context).push<MaterialPageRoute>(
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                                create: (BuildContext context) =>
                                    ConfirmCubit(),
                                child: const ConfirmPage());
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Visibility(
                      visible: state.error.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(
                          state.error,
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      BlocProvider.of<LoginCubit>(context).setData(
                          login: _loginController.text,
                          password: _passwordController.text),
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                    ),
                    child: const Text('Продолжить'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
