import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/secure_storage.dart';

part 'confirm_state.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  ConfirmCubit() : super(_initialState) {
    initState();
  }

  static ConfirmState get _initialState => ConfirmState(phone: _phone);

  static String _phone = '';
  String _verificationCode = '';
  String _enteredSmsCode = '';

  Future<void> initState() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();

    if (_preferences.containsKey('phone')) {
      _phone = _preferences.getString('phone')!;
      _preferences.remove('phone');
    }
    if (_preferences.containsKey('verification_code')) {
      _verificationCode = _preferences.getString('verification_code')!;
      _preferences.remove('verification_code');
    }
  }

  Future<void> incrementVerificationCode({required String value}) async {
    _enteredSmsCode = _enteredSmsCode + value;
    if (_enteredSmsCode.length == 4) {
      if (_enteredSmsCode == _verificationCode &&
          _verificationCode.isNotEmpty) {
        await SecureCtorage.setIsAuthorized(key: 'true');
        emit(ConfirmState(status: CodeStatus.success, phone: _phone));
      } else {
        _enteredSmsCode = '';
        emit(ConfirmState(status: CodeStatus.error, phone: _phone));
      }
    } else {
      emit(ConfirmState(phone: _phone));
    }
  }

  void onTimerComplete() {
    emit(const ConfirmState(timerIsWorcked: false));
  }

  void sendCodeAgain() {
    emit(const ConfirmState());
  }
}
