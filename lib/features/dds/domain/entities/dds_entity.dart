import 'package:equatable/equatable.dart';

class DDS extends Equatable {
  final String id;
  final String name;
  final bool isComing;

  const DDS({required this.id, required this.name, this.isComing = false});

  @override
  List<Object?> get props => [id, name, isComing];
}
