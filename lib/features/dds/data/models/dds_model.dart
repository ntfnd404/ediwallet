import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/dds_entity.dart';

part 'dds_model.g.dart';

@JsonSerializable()
class DDSModel extends DDS {
  const DDSModel(
      {required String id, required String name, required bool isComing})
      : super(id: id, name: name, isComing: isComing);

  factory DDSModel.fromJson(Map<String, dynamic> json) =>
      _$DDSModelFromJson(json);

  Map<String, dynamic> toJson() => _$DDSModelToJson(this);
}
