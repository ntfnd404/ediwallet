// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DDSModel _$DDSModelFromJson(Map<String, dynamic> json) {
  return DDSModel(
    id: json['id'] as String,
    name: json['name'] as String,
    isComing: json['isComing'] as bool,
  );
}

Map<String, dynamic> _$DDSModelToJson(DDSModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isComing': instance.isComing,
    };
