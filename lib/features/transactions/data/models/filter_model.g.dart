// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) {
  return FilterModel(
    name: json['name'] as String,
    isSelected: json['isSelected'] as bool,
  );
}

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isSelected': instance.isSelected,
    };
