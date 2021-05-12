import 'package:ediwallet/blocs/login_cubit/login_cubit.dart';
import 'package:ediwallet/screens/confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            // Color.fromRGBO(43, 136, 216, 1),
            // Color.fromRGBO(0, 31, 120, 1)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 132.0, left: 24.0, right: 24.0),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.error.isEmpty) {
                  Navigator.of(context).push<MaterialPageRoute>(
                    MaterialPageRoute(
                      builder: (context) => ConfirmPage(
                        verificationCode: state.verificationCode,
                        base64LoginPassword: state.base64LoginPassword,
                      ),
                    ),
                  );
                }
              },
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(
                          'Введите логин и пароль',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: TextField(
                          controller: _loginController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(),
                          decoration: const InputDecoration(
                            // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            // icon: Icon(Icons.send),
                            hintText: 'Логин',
                            labelText: 'Логин',
                            // helperText: 'Helper Text',
                            // counterText: '0 characters',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: TextField(
                          controller: _passwordController,
                          // style: TextStyle(),
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                            // icon: Icon(Icons.lock, color: Colors.deepPurple),
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
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            // icon: Icon(Icons.send),
                            hintText: 'Пароль',
                            labelText: 'Пароль',
                            // helperText: 'Helper Text',
                            // counterText: '0 characters',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Visibility(
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
