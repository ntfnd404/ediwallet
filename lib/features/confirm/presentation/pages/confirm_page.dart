import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../transactions/presentation/pages/home_page/home_page.dart';
import '../bloc/confirm_cubit.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  FocusNode pin1FocusNode = FocusNode();
  FocusNode pin2FocusNode = FocusNode();
  FocusNode pin3FocusNode = FocusNode();
  FocusNode pin4FocusNode = FocusNode();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  int beginTime = 30;

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
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 132.0, bottom: 30.0),
              child: Center(
                child: SizedBox(
                  width: 144.0,
                  height: 144.0,
                  child: Image.asset(
                    'assets/images/ic_phone_password_144.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const Text(
              'Введите код из смс',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 5.0),
                child: BlocBuilder<ConfirmCubit, ConfirmState>(
                  builder: (context, state) {
                    return RichText(
                      text: TextSpan(
                        text: 'Код выслан на номер: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: state.phone,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Выслать код повторно через: '),
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 30),
                  tween: IntTween(begin: beginTime, end: 0),
                  builder: (BuildContext context, value, child) {
                    // setState(() {
                    // beginTime--;
                    // });
                    return Text(
                      // String timer = value < 10 ? value.toString() : '20';
                      '00:$value',
                      style: const TextStyle(color: Colors.blue),
                    );
                  },
                  onEnd: () =>
                      BlocProvider.of<ConfirmCubit>(context).onTimerComplete(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: BlocConsumer<ConfirmCubit, ConfirmState>(
                listener: (context, state) {
                  switch (state.status) {
                    case CodeStatus.error:
                      controller1.text = '';
                      controller2.text = '';
                      controller3.text = '';
                      controller4.text = '';
                      pin1FocusNode.nextFocus();
                      break;
                    case CodeStatus.success:
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      break;
                    default:
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: TextField(
                              controller: controller1,
                              autofocus: true,
                              obscureText: true,
                              focusNode: pin1FocusNode,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.purple),
                                ),
                              ),
                              onChanged: (value) {
                                BlocProvider.of<ConfirmCubit>(context)
                                    .incrementVerificationCode(value: value);
                                nextField(
                                    value: value, focusNode: pin2FocusNode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: TextField(
                              controller: controller2,
                              autofocus: true,
                              obscureText: true,
                              focusNode: pin2FocusNode,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.purple),
                                ),
                              ),
                              onChanged: (value) {
                                BlocProvider.of<ConfirmCubit>(context)
                                    .incrementVerificationCode(value: value);
                                nextField(
                                    value: value, focusNode: pin3FocusNode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: TextField(
                              controller: controller3,
                              autofocus: true,
                              obscureText: true,
                              focusNode: pin3FocusNode,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.purple),
                                ),
                              ),
                              onChanged: (value) {
                                BlocProvider.of<ConfirmCubit>(context)
                                    .incrementVerificationCode(value: value);
                                nextField(
                                    value: value, focusNode: pin4FocusNode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: TextField(
                              controller: controller4,
                              autofocus: true,
                              obscureText: true,
                              focusNode: pin4FocusNode,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.purple),
                                ),
                              ),
                              onChanged: (value) {
                                BlocProvider.of<ConfirmCubit>(context)
                                    .incrementVerificationCode(value: value);
                                pin4FocusNode.unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Visibility(
                        visible: state.status == CodeStatus.error,
                        child: const Text(
                          'Не верный код подтверждения',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      // Spacer(),
                    ],
                  );
                },
              ),
            ),
            const Spacer(),
            BlocBuilder<ConfirmCubit, ConfirmState>(
              builder: (BuildContext context, state) {
                return AbsorbPointer(
                  absorbing: state.timerIsWorcked,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: state.timerIsWorcked ? Colors.grey : Colors.blue,
                    ),
                    // TODO: убрать setState()
                    onPressed: () {
                      setState(() {
                        beginTime = 36;
                      });
                      BlocProvider.of<ConfirmCubit>(context).sendCodeAgain();
                    },
                    child: const Text(
                      'Выслать код повторно',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15.0),
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.nextFocus();
    }
  }
}
