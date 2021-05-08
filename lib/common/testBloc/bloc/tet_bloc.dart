import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tet_event.dart';
part 'tet_state.dart';

class TetBloc extends Bloc<TetEvent, TetState> {
  TetBloc() : super(TetInitial());

  @override
  Stream<TetState> mapEventToState(
    TetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
