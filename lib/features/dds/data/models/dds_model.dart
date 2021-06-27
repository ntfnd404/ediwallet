import '../../domain/entities/dds_entity.dart';

class DDSModel extends DDS {
  const DDSModel(
      {required String id, required String name, required bool isComing})
      : super(id: id, name: name, isComing: isComing);

  factory DDSModel.fromJson(Map<String, dynamic> json) {
    return DDSModel(
        id: json['id'] as String,
        name: json['name'] as String,
        isComing: json['isComing'] == 1);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
