import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:ediwallet/common/bloc/scroll_event.dart';
import 'package:ediwallet/common/bloc/scroll_state.dart';
import 'package:ediwallet/transaction_page/models/transaction.dart';

class TransactionBloc extends Bloc<Event, ScrollState<Transaction>> {
  TransactionBloc(
      {required this.httpClient,
      required this.firstDate,
      required this.lastDate,
      required this.filterSettings})
      : super(ScrollState());

  http.Client httpClient;
  DateTime firstDate;
  DateTime lastDate;
  String filterSettings;

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
          event.isRefresh ? ScrollState<Transaction>() : state);
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
    final http.Response response = await httpClient.post(
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

    //   await httpClient
    //       .post(
    //     Uri.https('edison.group', '/cstest/hs/bookkeeping/pays'),
    //     headers: {
    //       'Accept': 'application/json',
    //       'Authorization': 'Basic bnRmbmQ6dmZuYmttbGY='
    //     },
    //     body:
    //         '{"FirstPage":"$startIndex","StartDate":"${firstDate.toString()}","EndDate":"${lastDate.toString()}","Filters":$filterSettings}',
    //   )
    //       .then((response) {
    //     if (response.statusCode == 200) {
    //       final body = json.decode(utf8.decode(response.bodyBytes)) as List;
    //       return body.map((dynamic json) {
    //         return Transaction(
    //           json['author'] as String,
    //           json['department'] as String,
    //           json['date'] as String,
    //           json['sum'] as int,
    //           json['source'] as String,
    //           json['time'] as String,
    //           json['type'] as String,
    //           json['user'] as String,
    //           json['analytics'] as String,
    //           json['mathSymbol'] as String,
    //         );
    //       }).toList();
    //     }
    //   }).onError(
    //     (error, stackTrace) => throw Exception(error),
    //   );

    throw Exception('Ошибка подключения к серверу');
  }

  void setParams(http.Client httpClient, DateTime firstDate, DateTime lastDate,
      String filterSettings) {
    this.httpClient = httpClient;
    this.firstDate = firstDate;
    this.lastDate = lastDate;
    this.filterSettings = filterSettings;
  }
}
