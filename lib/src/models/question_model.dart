// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

import 'package:discover_meet/src/models/questionnaire_model.dart';

class QuestionModel {
  String id;
  String title;
  String type;
  int? minValue;
  int? maxValue;
  List<String> options;
  DateTime createdAt;
  DateTime updateAt;
  QuestionnaireModel questionnaire;

  QuestionModel({
    required this.id,
    required this.title,
    required this.type,
    this.minValue,
    this.maxValue,
    required this.options,
    required this.createdAt,
    required this.updateAt,
    required this.questionnaire,
  });

  factory QuestionModel.fromRawJson(String str) =>
      QuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        minValue: json["minValue"],
        maxValue: json["maxValue"],
        options: List<String>.from(json["options"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
        questionnaire: QuestionnaireModel.fromJson(json["questionnaire"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "minValue": minValue,
        "maxValue": maxValue,
        "options": List<dynamic>.from(options.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updateAt": updateAt.toIso8601String(),
        "questionnaire": questionnaire.toJson(),
      };
}
