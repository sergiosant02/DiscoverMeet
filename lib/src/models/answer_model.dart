// To parse this JSON data, do
//
//     final answerModel = answerModelFromJson(jsonString);

import 'dart:convert';

import 'package:discover_meet/src/models/question_model.dart';
import 'package:discover_meet/src/models/user_model.dart';

class AnswerModel {
  String id;
  List<String> value;
  DateTime createdAt;
  DateTime updateAt;
  QuestionModel question;
  UserModel user;

  AnswerModel({
    required this.id,
    required this.value,
    required this.createdAt,
    required this.updateAt,
    required this.question,
    required this.user,
  });

  factory AnswerModel.fromRawJson(String str) =>
      AnswerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        id: json["_id"],
        value: List<String>.from(json["value"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
        question: QuestionModel.fromJson(json["question"]),
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "value": List<dynamic>.from(value.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updateAt": updateAt.toIso8601String(),
        "question": question.toJson(),
        "user": user.toJson(),
      };
}
