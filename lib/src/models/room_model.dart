import 'package:discover_meet/src/models/json_convert_interface.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:developer' as dev;

import '../utils/utils.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel implements JsonConvertInterface {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "participants")
  List<UserModel> participants;
  @JsonKey(name: "owner")
  UserModel owner;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  RoomModel({
    required this.id,
    required this.title,
    required this.participants,
    required this.owner,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  static List<RoomModel> fromJsonList(String body) {
    body = Utils.formatJson(body);
    List<RoomModel> res = [];
    dynamic decodedData = json.decode(body);
    try {
      for (var map in decodedData) {
        Map<String, dynamic> info = map;
        RoomModel room = RoomModel.fromJson(info);
        res.add(room);
      }
    } catch (e) {
      dev.log(e.toString());
    }
    return res;
  }
}
