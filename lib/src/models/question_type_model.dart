import 'dart:convert';

import 'package:discover_meet/src/models/QuestionType.dart';
import 'package:discover_meet/src/models/json_convert_interface.dart';

class QuestionTypeModel implements JsonConvertInterface {
  String id;
  QuestionType type;

  QuestionTypeModel({
    required this.id,
    required this.type,
  });

  factory QuestionTypeModel.fromRawJson(String str) =>
      QuestionTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionTypeModel.fromJson(Map<String, dynamic> json) =>
      QuestionTypeModel(
        id: json["_id"],
        type: QuestionType.format(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
      };
}
