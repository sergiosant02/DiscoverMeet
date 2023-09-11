import 'package:discover_meet/src/models/Option_model.dart';
import 'package:discover_meet/src/models/question_type_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import '../utils/utils.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "type")
  QuestionTypeModel type;
  @JsonKey(name: "minValue")
  int? minValue;
  @JsonKey(name: "maxValue")
  int? maxValue;
  @JsonKey(name: "options")
  List<OptionModel> options;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "questionnaire")
  String questionnaire;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  QuestionModel({
    required this.title,
    required this.type,
    required this.minValue,
    required this.maxValue,
    required this.options,
    required this.id,
    required this.questionnaire,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  static List<QuestionModel> fromJsonList(String body) {
    body = Utils.formatJson(body);
    List<QuestionModel> res = [];
    dynamic decodedData = json.decode(body);
    try {
      for (var map in decodedData) {
        print(map['_id']);
        print(map['questionnaire']);
        QuestionModel question = QuestionModel.fromJson(map);
        res.add(question);
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
}

@JsonSerializable()
class Questionnaire {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "intents")
  int intents;
  @JsonKey(name: "frequency")
  String frequency;
  @JsonKey(name: "draftmode")
  bool draftmode;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "enable")
  bool enable;
  @JsonKey(name: "room")
  Room room;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Questionnaire({
    required this.id,
    required this.title,
    required this.intents,
    required this.frequency,
    required this.draftmode,
    required this.description,
    required this.enable,
    required this.room,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
}

@JsonSerializable()
class Room {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "participants")
  List<String> participants;
  @JsonKey(name: "owner")
  String owner;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Room({
    required this.id,
    required this.title,
    required this.participants,
    required this.owner,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Type({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
