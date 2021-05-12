import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:ediwallet/models/transaction.dart';
import 'package:ediwallet/blocs/bloc/scroll_event.dart';
import 'package:ediwallet/blocs/bloc_event.dart';
import 'package:ediwallet/blocs/scroll_state.dart';
import 'package:ediwallet/screens/home_page/filters_list/models/filters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsListBloc extends Bloc<Event, ScrollState<Transaction>> {
  TransactionsListBloc() : super(const ScrollState<Transaction>());

  final http.Client _httpClient = http.Client();
  String filterSettings = Filters().toJson();

  @override
  Stream<Transition<Event, ScrollState<Transaction>>> transformEvents(
    Stream<Event> events,
    TransitionFunction<Event, ScrollState<Transaction>> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
  Stream<ScrollState<Transaction>> mapEventToState(Event event) async* {
    if (event is ScrollEvent) {
      yield await _mapDDSFetchedToState(
          event.isRefresh ? const ScrollState<Transaction>() : state);
    }
  }

  Future<ScrollState<Transaction>> _mapDDSFetchedToState(
      ScrollState<Transaction> state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == StateStatus.initial) {
        final items = await _fetchItems();
        return state.copyWith(
          status: StateStatus.success,
          items: items,
          hasReachedMax: items.length < 30 || false,
        );
      }
      final items = await _fetchItems(state.items.length);
      return items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: StateStatus.success,
              items: List.of(state.items)..addAll(items),
              hasReachedMax: items.length < 30 || false,
            );
    } on Exception {
      return state.copyWith(status: StateStatus.failure);
    }
  }

  Future<List<Transaction>> _fetchItems([int startIndex = 0]) async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('Нет интернет соединения');
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? _dateTimeString = prefs.getStringList('date_time');
    final String _firstDate = _dateTimeString != null
        ? _dateTimeString[0]
        : DateTime.now().add(const Duration(days: -7)).toString();
    final String _lastDate = _dateTimeString != null
        ? _dateTimeString[1]
        : DateTime.now().toString();

    final http.Response response = await _httpClient.post(
        Uri.https('edison.group', '/cstest/hs/bookkeeping/pays'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Basic bnRmbmQ6dmZuYmttbGY='
        },
        body:
            '{"FirstPage":"$startIndex","StartDate":"$_firstDate","EndDate":"$_lastDate","Filters":$filterSettings}');

    if (response.statusCode == 200) {
      final List body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body.map((dynamic json) {
        return Transaction(
          json['author'] as String,
          json['department'] as String,
          json['date'] as String,
          json['sum'] as int,
          json['source'] as String,
          json['time'] as String,
          json['type'] as String,
          json['user'] as String,
          json['analytics'] as String,
          json['mathSymbol'] as String,
        );
      }).toList();
    }

    throw Exception('Ошибка подключения к серверу');
  }
}
