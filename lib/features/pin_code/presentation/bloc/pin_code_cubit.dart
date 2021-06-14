import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pin_code_cubit_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  String _firstCode = '';
  final String _confirmCode = '';

  PinCodeCubit() : super(PinCodeInitial());

  void addNumber(int number) {
    if (_firstCode.length < 4) {
      _firstCode = _firstCode + number.toString();
      if (_firstCode.length == 4) {
        emit(const PinCodeConfirmInProcess());
      } else {
        emit(PinCodeCreateInProcess(pinedCount: _firstCode.length));
      }
    } else if (_firstCode.length == 4) {
      if (_confirmCode.length == 4) {
        if (_firstCode == _confirmCode) {
          emit(PinCodeConfirmed());
        } else {
          emit(PinCodeConfirmError());
        }
      } else {
        emit(PinCodeConfirmInProcess(pinedCount: _firstCode.length));
      }
    }
  }

  void deleteLastNumber() {}
}
