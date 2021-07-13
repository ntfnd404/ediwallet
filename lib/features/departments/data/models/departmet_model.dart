import 'package:ediwallet/features/departments/domain/entities/department_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'departmet_model.g.dart';

@JsonSerializable()
class DepartmentModel extends Department {
  const DepartmentModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);
}
