import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:ediwallet/blocs/bloc_event.dart';
import 'package:ediwallet/blocs/scroll_state.dart';
import 'package:ediwallet/models/dds.dart';
import 'package:ediwallet/blocs/bloc/scroll_event.dart';

class DDSBloc extends Bloc<Event, ScrollState<DDS>> {
  DDSBloc({required this.httpClient}) : super(const ScrollState());

  final http.Client httpClient;
  // final BaseRepository repository;

  @override
  Stream<Transition<Event, ScrollState<DDS>>> transformEvents(
    Stream<Event> events,
    TransitionFunction<Event, ScrollState<DDS>> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
  Stream<ScrollState<DDS>> mapEventToState(Event event) async* {
    if (event is ScrollEvent) {
      yield await _mapDDSFetchedToState(
          event.isRefresh ? const ScrollState<DDS>() : state);
    }
  }

  Future<ScrollState<DDS>> _mapDDSFetchedToState(ScrollState<DDS> state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == StateStatus.initial) {
        final items = await _fetchItems();
        return state.copyWith(
          status: StateStatus.success,
          items: items,
          hasReachedMax: items.length <= 30 || false,
        );
      }
      final items = await _fetchItems(state.items.length);
      // final items = await repository.fetchItems(state.items.length);
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

  Future<List<DDS>> _fetchItems([int startIndex = 0]) async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('Нет интернет соединения');
    }

    final response = await httpClient.get(
      Uri.https('edison.group', '/cstest/hs/bookkeeping/dds/$startIndex'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Basic bnRmbmQ6dmZuYmttbGY='
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body.map((dynamic json) {
        return DDS(
          id: json['id'] as String,
          name: json['name'] as String,
          isComing: json['is_coming'] == 1 || false,
        );
      }).toList();
    }

    throw Exception('Ошибка подключения к серверу');
  }
}
