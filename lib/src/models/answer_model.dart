import 'dart:developer' as dev;

import 'package:discover_meet/src/models/Option_model.dart';
import 'package:discover_meet/src/models/json_convert_interface.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:discover_meet/src/models/question_model.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import '../utils/utils.dart';

part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel implements JsonConvertInterface {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "value")
  List<OptionModel> value;
  @JsonKey(name: "question")
  QuestionModel question;
  @JsonKey(name: "user")
  UserModel? user;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  AnswerModel({
    this.id,
    required this.value,
    required this.question,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);

  static List<AnswerModel> fromJsonList(String body) {
    body = Utils.formatJson(body);
    List<AnswerModel> res = [];
    dynamic decodedData = json.decode(body);
    try {
      for (var map in decodedData) {
        var map2 = jsonDecode(map);
        Map<String, dynamic> info = map2;
        AnswerModel answer = AnswerModel.fromJson(info);
        res.add(answer);
      }
    } catch (e) {
      dev.log(e.toString());
    }
    return res;
  }
}
