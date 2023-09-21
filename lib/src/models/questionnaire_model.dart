import 'dart:convert';

import 'package:discover_meet/src/models/json_convert_interface.dart';
import 'dart:developer' as dev;

import '../utils/utils.dart';

class QuestionnaireModel implements JsonConvertInterface {
  String id;
  bool enable;
  int intents;
  String frecuencia;
  bool draftmode;
  DateTime createdAt;
  DateTime updateAt;
  String roomId;
  String title;
  String description;

  QuestionnaireModel(
      {required this.id,
      required this.enable,
      required this.intents,
      required this.frecuencia,
      required this.draftmode,
      required this.createdAt,
      required this.updateAt,
      required this.roomId,
      required this.title,
      required this.description});

  factory QuestionnaireModel.fromRawJson(String str) =>
      QuestionnaireModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) =>
      QuestionnaireModel(
          id: json["_id"],
          enable: json["enable"],
          intents: json["intents"],
          frecuencia: json["frequency"],
          draftmode: json["draftmode"],
          createdAt: DateTime.parse(json["createdAt"]),
          updateAt: DateTime.parse(json["updatedAt"]),
          roomId: json["room"],
          title: json["title"],
          description: json['description']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enable": enable,
        "intents": intents,
        "frequency": frecuencia,
        "draftmode": draftmode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updateAt.toIso8601String(),
        "room": roomId,
        'title': title,
        'description': description
      };

  static List<QuestionnaireModel> fromJsonList(String body) {
    body = Utils.formatJson(body);
    List<QuestionnaireModel> res = [];
    dynamic decodedData = json.decode(body);
    try {
      for (var map in decodedData) {
        Map<String, dynamic> info = map;
        QuestionnaireModel questionnaire = QuestionnaireModel.fromJson(info);
        res.add(questionnaire);
      }
    } catch (e) {
      dev.log(e.toString());
    }
    return res;
  }
}
