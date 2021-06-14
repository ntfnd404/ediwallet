import 'package:ediwallet/features/pin_code/presentation/bloc/pin_code_cubit.dart';
// import 'package:ediwallet/features/pin_code/presentation/widgets/pin_animation_widget.dart';
import 'package:ediwallet/features/pin_code/presentation/widgets/pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({Key? key}) : super(key: key);

  @override
  _PinCodePageState createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  // final PinAnimationController animationController = PinAnimationController();

  @override
  Widget build(BuildContext context) {
    final PinController pinController = PinController();

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
            padding: const EdgeInsets.only(top: 108, left: 24.0, right: 24.0),
            child: BlocProvider<PinCodeCubit>(
              create: (context) => PinCodeCubit(),
              child: BlocConsumer<PinCodeCubit, PinCodeState>(
                listener: (context, state) {
                  if (state is PinCodeCreated) {
                    // TODO: обработать логику
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      const Center(
                        child: Text(
                          'Создайте пинкод',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Center(
                        child: Text(
                            state is PinCodeConfirmInProcess
                                ? 'Подтвердите пинкод'
                                : 'Создайте четырехзначный пинкод для защиты вашего аккаунта',
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PinWidget(pinLegth: 4, pinController: pinController),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        childAspectRatio: 1.1,
                        children: List.generate(
                          9,
                          (index) => KeyboardNumber(
                            n: index + 1,
                            controller: pinController,
                          ),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 60.0,
                            width: 60.0,
                          ),
                          KeyboardNumber(
                            n: 0,
                            controller: pinController,
                          ),
                          KeyboardNumber(
                            controller: pinController,
                          ),
                        ],
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

class KeyboardNumber extends StatelessWidget {
  final int? n;
  final int countPined;
  final PinController controller;
  const KeyboardNumber(
      {Key? key, this.n, required this.controller, this.countPined = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (n != null) {
          BlocProvider.of<PinCodeCubit>(context).addNumber(n!);
          if (countPined == 4) {
            controller.clearAll();
          } else {
            controller.addInput('$n');
          }
        } else {
          BlocProvider.of<PinCodeCubit>(context).deleteLastNumber();
          controller.delete();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 60.0,
        height: 60.0,
        child: n != null
            ? Center(
                child: Text(
                  n.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 50.0),
                ),
              )
            : const Icon(Icons.backspace_outlined),
      ),
    );
  }
}
