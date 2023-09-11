// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      title: json['title'] as String,
      type: QuestionTypeModel.fromJson(json['type'] as Map<String, dynamic>),
      minValue: json['minValue'] as int?,
      maxValue: json['maxValue'] as int?,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
      questionnaire: json['questionnaire'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'options': instance.options,
      '_id': instance.id,
      'questionnaire': instance.questionnaire,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

Questionnaire _$QuestionnaireFromJson(Map<String, dynamic> json) =>
    Questionnaire(
      id: json['_id'] as String,
      title: json['title'] as String,
      intents: json['intents'] as int,
      frequency: json['frequency'] as String,
      draftmode: json['draftmode'] as bool,
      description: json['description'] as String,
      enable: json['enable'] as bool,
      room: Room.fromJson(json['room'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$QuestionnaireToJson(Questionnaire instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'intents': instance.intents,
      'frequency': instance.frequency,
      'draftmode': instance.draftmode,
      'description': instance.description,
      'enable': instance.enable,
      'room': instance.room,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      id: json['_id'] as String,
      title: json['title'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      owner: json['owner'] as String,
      code: json['code'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'participants': instance.participants,
      'owner': instance.owner,
      'code': instance.code,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: json['_id'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
