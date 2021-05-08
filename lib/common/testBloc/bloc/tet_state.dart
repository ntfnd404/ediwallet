part of 'tet_bloc.dart';

abstract class TetState extends Equatable {
  const TetState();
  
  @override
  List<Object> get props => [];
}

class TetInitial extends TetState {}
