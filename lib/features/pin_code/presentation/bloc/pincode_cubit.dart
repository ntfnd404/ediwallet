import 'package:bloc/bloc.dart';
import 'package:ediwallet/core/secure_storage.dart';
import 'package:equatable/equatable.dart';

part 'pincode_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  String code = '';
  // SecureCtorage.getPin().then((value) => code = value);

  String enteredCode = '';
  PinCodeCubit() : super(PinCodeInitial()) {
    SecureCtorage.getPin().then((value) => code = value!);
  }

  Future addNumber(int number) async {
    if (enteredCode.length < 4) {
      enteredCode = enteredCode + number.toString();
    }
    if (enteredCode.length == 4) {
      if (state is PinCodeInProcess && enteredCode == code) {
        emit(PinCodeConfirmed());
      } else {
        enteredCode = '';
        emit(PinCodeError());
      }
    } else {
      emit(PinCodeInProcess());
    }
  }

  void deleteLastNumber() {
    if (enteredCode.isNotEmpty) {
      enteredCode = enteredCode.substring(0, enteredCode.length - 1);
    }
  }
}
