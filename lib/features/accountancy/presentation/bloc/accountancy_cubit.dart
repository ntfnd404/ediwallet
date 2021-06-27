import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'accountancy_state.dart';

class AccountancyCubit extends Cubit<AccountancySucces> {
  final Client _httpClient = Client();

  AccountancyCubit() : super(const AccountancySucces());

  Future<void> fetchItems() async {
    // final ConnectivityResult connectivityResult =
    //     await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   throw Exception('Нет интернет соединения');
    // }

    // TODO: переделать на Clean architecture
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? _dateTimeString = prefs.getStringList('date_time');
    final String _firstDate = _dateTimeString != null
        ? _dateTimeString[0]
        : DateTime.now().add(const Duration(days: -7)).toString();
    final String _lastDate = _dateTimeString != null
        ? _dateTimeString[1]
        : DateTime.now().toString();

    final Response response = await _httpClient.get(
      Uri.https('edison.group',
          '/cstest/hs/bookkeeping/accountancy?start_date=$_firstDate&end_date=$_lastDate'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Basic bnRmbmQ6dmZuYmttbGY='
      },
    );

    if (response.statusCode == 200) {
      final body =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      emit(AccountancySucces(
          income: body['income']! as String,
          outcome: body['outcome']! as String,
          cash: body['cash']! as String,
          debt: body['debt']! as String,
          balance: body['balance']! as String));
    } else if (response.statusCode == 614) {
      // throw Exception('Отсутсвуют данные');
      emit(const AccountancySucces());
    } else {
      throw Exception('Ошибка подключения к серверу');
    }
  }
}
