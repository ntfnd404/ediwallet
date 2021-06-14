import 'package:ediwallet/features/pin_code/presentation/widgets/pin_animation_widget.dart';
import 'package:flutter/material.dart';

class PinWidget extends StatefulWidget {
  final int pinLegth;
  final PinController pinController;

  const PinWidget(
      {Key? key, required this.pinLegth, required this.pinController})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _PinWidgetState createState() => _PinWidgetState(pinController);
}

class _PinWidgetState extends State<PinWidget> {
  late List<PinAnimationController> _animationControllers;
  String pin = '';

  _PinWidgetState(PinController controller) {
    controller.addInput = addInput;
    controller.delete = delete;
    controller.clearAll = clearAll;
  }

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      widget.pinLegth,
      (index) => PinAnimationController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLegth, (index) {
        return PinAnimationWidget(
          controller: _animationControllers[index],
        );
      }),
    );
  }

  void addInput(String input) {
    pin += input;
    if (pin.length <= widget.pinLegth) {
      _animationControllers[pin.length - 1].animate(input);
    }
  }

  void delete() {
    if (pin.isNotEmpty) {
      pin = pin.substring(0, pin.length - 1);
      _animationControllers[pin.length].animate('');
    }
  }

  void clearAll() {
    if (pin.isNotEmpty) {
      // pin = pin.substring(0, pin.length - 1);
      // _animationControllers[pin.length].animate('');
    }
  }
}

class PinController {
  late void Function(String) addInput;
  late void Function() delete;
  late void Function() clearAll;
}
