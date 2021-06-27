import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/secure_storage.dart';

part 'pin_code_cubit_state.dart';

class PinCodeCubit extends Cubit<PinCodeCreateState> {
  String _firstCode = '';
  String _confirmCode = '';

  PinCodeCubit() : super(PinCodeInitial());

  Future addNumber(int number) async {
    if (_firstCode.length < 4) {
      _firstCode = _firstCode + number.toString();
    }
    if (_firstCode.length == 4) {
      if (state is PinCodeCreateInProcess) {
        emit(PinCodeConfirmInProcess());
      } else if (state is PinCodeConfirmInProcess ||
          state is PinCodeConfirmError) {
        if (_confirmCode.length < 4) {
          _confirmCode = _confirmCode + number.toString();
        }
        if (_confirmCode.length == 4) {
          if (_firstCode == _confirmCode) {
            await SecureCtorage.enablePin(isEnabled: true);
            await SecureCtorage.setPin(pin: _confirmCode);
            emit(PinCodeConfirmed());
          } else {
            _confirmCode = '';
            emit(PinCodeConfirmError());
          }
        } else {
          emit(PinCodeConfirmInProcess());
        }
      }
    } else {
      emit(PinCodeCreateInProcess());
    }
  }

  void deleteLastNumber() {
    if (state is PinCodeCreateInProcess) {
      if (_firstCode.isNotEmpty) {
        _firstCode = _firstCode.substring(0, _firstCode.length - 1);
      }
    } else if (state is PinCodeConfirmInProcess) {
      if (_confirmCode.isNotEmpty) {
        _confirmCode = _confirmCode.substring(0, _confirmCode.length - 1);
      }
    }
  }
}
