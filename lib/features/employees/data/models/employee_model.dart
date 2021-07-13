import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/employee_entity.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel extends Employee {
  const EmployeeModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
