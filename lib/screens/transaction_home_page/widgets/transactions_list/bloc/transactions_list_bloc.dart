import 'dart:convert';
import 'package:ediwallet/common/bloc/bloc_event.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/models/filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:ediwallet/common/bloc/scroll_state.dart';
import 'package:ediwallet/screens/transaction_home_page/models/transaction.dart';
import 'package:ediwallet/screens/transaction_home_page/bloc/scroll_event.dart';

class TransactionsListBloc extends Bloc<Event, ScrollState<Transaction>> {
  TransactionsListBloc() : super(const ScrollState<Transaction>());

  final http.Client _httpClient = http.Client();
  DateTime firstDate = DateTime.now().add(const Duration(days: -7));
  DateTime lastDate = DateTime.now();
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
    // switch
    if (event is ScrollEvent) {
      if (event.firstDate != null) firstDate = event.firstDate!;
      if (event.lastDate != null) lastDate = event.lastDate!;
      if (event.filterSettings != null) filterSettings = event.filterSettings!;

      yield await _mapDDSFetchedToState(
          event.isRefresh ? const ScrollState<Transaction>() : state);
    }
    // else if(event is SetDateEvent){
    // firstDate = event.startDate;
    // yield await _mapDDSFetchedToState(ScrollState<Transaction>());
    // }
    // else if(event is SetFilterEvent){
// filterSettings = event.startDate;
    // yield await _mapDDSFetchedToState(ScrollState<Transaction>());
    // }
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
    final http.Response response = await _httpClient.post(
        Uri.https('edison.group', '/cstest/hs/bookkeeping/pays'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Basic bnRmbmQ6dmZuYmttbGY='
        },
        body:
            '{"FirstPage":"$startIndex","StartDate":"${firstDate.toString()}","EndDate":"${lastDate.toString()}","Filters":$filterSettings}');

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

  void setParams(DateTime firstDate, DateTime lastDate, String filterSettings) {
    this.firstDate = firstDate;
    this.lastDate = lastDate;
    this.filterSettings = filterSettings;
  }
}
