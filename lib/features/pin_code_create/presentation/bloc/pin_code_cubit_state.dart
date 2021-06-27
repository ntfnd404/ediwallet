part of 'pin_code_cubit.dart';

abstract class PinCodeCreateState extends Equatable {
  const PinCodeCreateState();

  @override
  List<Object> get props => [];
}

class PinCodeInitial extends PinCodeCreateState {}

class PinCodeCreateInProcess extends PinCodeCreateState {}

class PinCodeConfirmInProcess extends PinCodeCreateState {}

class PinCodeConfirmed extends PinCodeCreateState {}

class PinCodeConfirmError extends PinCodeCreateState {}
