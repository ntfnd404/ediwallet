import 'package:flutter/material.dart';

import 'pin_animation_widget.dart';

class PinController {
  late void Function(String) addInput;
  late void Function() delete;
  late void Function() deleteAll;
  late void Function() notifyWrongInput;
}

class PinWidget extends StatefulWidget {
  final int pinLegth;
  final PinController pinController;
  final Function(String) onCompleted;

  const PinWidget(
      {Key? key,
      required this.pinLegth,
      required this.pinController,
      required this.onCompleted})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _PinWidgetState createState() => _PinWidgetState(pinController);
}

class _PinWidgetState extends State<PinWidget>
    with SingleTickerProviderStateMixin {
  late List<PinAnimationController> _animationControllers;
  late AnimationController _wrongInputAnimationController;
  late Animation<double> _wiggleAnimation;
  String pin = '';

  _PinWidgetState(PinController controller) {
    controller.addInput = addInput;
    controller.delete = delete;
    controller.deleteAll = deleteAll;
    controller.notifyWrongInput = notifyWrongInput;
  }

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      widget.pinLegth,
      (index) => PinAnimationController(),
    );
    _wrongInputAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _wrongInputAnimationController.reverse();
        }
      });
    _wiggleAnimation = Tween<double>(begin: 0.0, end: 24.0).animate(
      CurvedAnimation(
          parent: _wrongInputAnimationController, curve: Curves.elasticIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_wiggleAnimation.value, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.pinLegth, (index) {
          return PinAnimationWidget(
            controller: _animationControllers[index],
          );
        }),
      ),
    );
  }

  Future addInput(String input) async {
    pin += input;
    if (pin.length < widget.pinLegth) {
      _animationControllers[pin.length - 1].animate(input);
    } else if (pin.length == widget.pinLegth) {
      _animationControllers[pin.length - 1].animate(input);
      await Future.delayed(const Duration(milliseconds: 500));
      deleteAll();
    }
    widget.onCompleted.call(input);
  }

  void delete() {
    if (pin.isNotEmpty) {
      pin = pin.substring(0, pin.length - 1);
      _animationControllers[pin.length].animate('');
    }
  }

  void deleteAll() {
    pin = '';
    for (final controller in _animationControllers) {
      controller.clear();
    }
  }

  void notifyWrongInput() {
    _wrongInputAnimationController.forward();
    deleteAll();
  }
}
