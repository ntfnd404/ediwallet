import 'package:ediwallet/features/dds/domain/entities/dds_entity.dart';

class DDSModel extends DDS {
  const DDSModel(
      {required String id, required String name, required bool isComing})
      : super(id: id, name: name, isComing: isComing);

  factory DDSModel.fromJson(Map<String, dynamic> json) {
    return DDSModel(
        id: json['id'] as String,
        name: json['name'] as String,
        isComing: json['is_coming'] as bool);
  }

  Map<String, String> toJson() => {'id': id, 'name': name};
}
