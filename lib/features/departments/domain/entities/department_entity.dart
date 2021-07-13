import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String id;
  final String name;

  const Department({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
