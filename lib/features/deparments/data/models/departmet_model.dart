import 'package:ediwallet/features/deparments/domain/entities/department_entity.dart';

class DepartmentModel extends Department {
  const DepartmentModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
