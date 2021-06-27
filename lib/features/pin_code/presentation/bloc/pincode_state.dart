part of 'pincode_cubit.dart';

abstract class PinCodeState extends Equatable {
  const PinCodeState();

  @override
  List<Object> get props => [];
}

class PinCodeInitial extends PinCodeState {}

class PinCodeError extends PinCodeState {}

class PinCodeInProcess extends PinCodeState {}

class PinCodeConfirmInProcess extends PinCodeState {}

class PinCodeConfirmed extends PinCodeState {}
