// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionModel _$OptionModelFromJson(Map<String, dynamic> json) => OptionModel(
      id: json['_id'] as String?,
      opt: json['opt'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'opt': instance.opt,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
