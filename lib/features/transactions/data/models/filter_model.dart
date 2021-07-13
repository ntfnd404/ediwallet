import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/filter_entity.dart';

part 'filter_model.g.dart';

@JsonSerializable()
class FilterModel extends FilterItem {
  const FilterModel({required String name, bool isSelected = false})
      : super(name: name, isSelected: isSelected);

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);

  FilterItem copyWith({bool? isSelected}) =>
      FilterItem(name: name, isSelected: isSelected ?? this.isSelected);
}
