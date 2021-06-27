import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Client _httpClient = Client();

  LoginCubit() : super(const LoginState());

  Future<void> setData(
      {required String login, required String password}) async {
    // final ConnectivityResult connectivityResult =
    //     await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   emit(const LoginState(error: 'Нет интернет соединения'));
    // }

    final String _unConvertedString = "$login:$password";
    final List<int> _bytes = utf8.encode(_unConvertedString);
    final String _base64String = base64.encode(_bytes);
    final String _verificationCode = (Random().nextInt(9999) + 1000).toString();

    final Response response = await _httpClient.get(
      Uri.https('edison.group',
          '/cstest/hs/bookkeeping/confirmsmscode?confirmsmscode=$_verificationCode'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Basic $_base64String'
      },
    );

    switch (response.statusCode) {
      case 200:
        final String _phone =
            json.decode(utf8.decode(response.bodyBytes))['phone'] as String;

        SecureCtorage.setAuthKey(key: _base64String);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', _phone);
        await prefs.setString('verification_code', _verificationCode);

        emit(const LoginState(submissionSuccess: true));
        break;
      case 401:
        emit(const LoginState(error: 'Не верные данные авторизации'));
        break;
      case 615:
        emit(
            const LoginState(error: 'Телефон пользователя не зарегистрирован'));
        break;
      default:
        emit(const LoginState(error: 'Ошибка подключения к серверу'));
    }
  }
}
