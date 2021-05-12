import 'package:flutter/material.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage(
      {Key? key,
      required this.verificationCode,
      required this.base64LoginPassword})
      : super(key: key);

  final String verificationCode;
  final String base64LoginPassword;

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
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'Введите код из смс',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    const Text('Код можно будет выслать повторно через: '),
                    TweenAnimationBuilder(
                      duration: const Duration(seconds: 10),
                      tween: Tween(begin: 10, end: 0),
                      builder: (BuildContext context, int value, child) => Text(
                        '00:${value.toInt()}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      onEnd: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
