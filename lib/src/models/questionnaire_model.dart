// To parse this JSON data, do
//
//     final questionnaireModel = questionnaireModelFromJson(jsonString);

import 'dart:convert';

class QuestionnaireModel {
  String id;
  bool enable;
  bool evaluable;
  int intents;
  String frecuencia;
  bool draftMode;
  DateTime createdAt;
  DateTime updateAt;
  String roomId;

  QuestionnaireModel({
    required this.id,
    required this.enable,
    required this.evaluable,
    required this.intents,
    required this.frecuencia,
    required this.draftMode,
    required this.createdAt,
    required this.updateAt,
    required this.roomId,
  });

  factory QuestionnaireModel.fromRawJson(String str) =>
      QuestionnaireModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) =>
      QuestionnaireModel(
        id: json["_id"],
        enable: json["enable"],
        evaluable: json["evaluable"],
        intents: json["intents"],
        frecuencia: json["frecuencia"],
        draftMode: json["draftMode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
        roomId: json["room"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enable": enable,
        "evaluable": evaluable,
        "intents": intents,
        "frecuencia": frecuencia,
        "draftMode": draftMode,
        "createdAt": createdAt.toIso8601String(),
        "updateAt": updateAt.toIso8601String(),
        "room": roomId,
      };
}
