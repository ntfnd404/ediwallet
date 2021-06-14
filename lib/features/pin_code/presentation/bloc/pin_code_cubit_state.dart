// import 'package:equatable/equatable.dart';

part of 'pin_code_cubit.dart';

abstract class PinCodeState extends Equatable {
  const PinCodeState();

  @override
  List<Object> get props => [];
}

class PinCodeInitial extends PinCodeState {}

class PinCodeCreateInProcess extends PinCodeState {
  final int pinedCount;
  const PinCodeCreateInProcess({this.pinedCount = 0});
  @override
  List<Object> get props => [pinedCount];
}

class PinCodeConfirmInProcess extends PinCodeState {
  final int pinedCount;
  const PinCodeConfirmInProcess({this.pinedCount = 0});
  @override
  List<Object> get props => [pinedCount];
}

class PinCodeCreated extends PinCodeState {}

class PinCodeConfirmed extends PinCodeState {}

class PinCodeConfirmError extends PinCodeState {}

// class PinCodeDeleteNumber extends PinCodeState {}
