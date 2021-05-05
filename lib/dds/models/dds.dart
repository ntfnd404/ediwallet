import 'package:equatable/equatable.dart';

class DDS extends Equatable {
  const DDS({required this.id, required this.name, this.isComing = false});

  final String id;
  final String name;
  final bool isComing;

  @override
  List<Object?> get props => [id, name, isComing];

  // static final columns = ['id', 'name'];

  factory DDS.fromJson(Map<String, dynamic> json) {
    return DDS(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, String> toJson() => {'id': id, 'name': name};
}
