import 'package:flutter/material.dart';

class PinAnimationController {
  late void Function(String) animate;
  late void Function() clear;
}

class PinAnimationWidget extends StatefulWidget {
  final PinAnimationController controller;

  const PinAnimationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PinAnimationWidgetState createState() =>
      // ignore: no_logic_in_create_state
      _PinAnimationWidgetState(controller);
}

class _PinAnimationWidgetState extends State<PinAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  String pin = '';

  _PinAnimationWidgetState(controller) {
    controller.animate = animate;
    controller.clear = clear;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      }
      setState(() {});
    });
    _sizeAnimation =
        Tween<double>(begin: 24, end: 72).animate(_animationController);
    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    // final value = context.findAncestorStateOfType().controller

    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      child: Container(
        height: _sizeAnimation.value,
        width: _sizeAnimation.value,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_sizeAnimation.value / 2),
          color: pin == '' ? Colors.grey : Theme.of(context).primaryColor,
        ),
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _sizeAnimation.value / 48,
            child: Text(
              pin,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate(String input) {
    _animationController.forward();
    setState(() {
      pin = input;
    });
  }

  void clear() {
    setState(() {
      pin = '';
    });
  }
}
