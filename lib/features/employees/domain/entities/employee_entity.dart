import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;

  const Employee({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
