import 'dart:convert';

import 'package:discover_meet/src/models/user_model.dart';

class RoomModel {
  String id;
  String title;
  List<UserModel> participants;
  DateTime createdAt;
  DateTime updateAt;
  UserModel owner;
  String code;
  int v;

  RoomModel({
    required this.id,
    required this.title,
    required this.participants,
    required this.createdAt,
    required this.updateAt,
    required this.owner,
    required this.code,
    required this.v,
  });

  factory RoomModel.fromRawJson(String str) =>
      RoomModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json["_id"],
        title: json["title"],
        participants: List<UserModel>.from(
            json["participants"].map((x) => UserModel.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
        owner: UserModel.fromJson(json["owner"]),
        code: json["code"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updateAt": updateAt.toIso8601String(),
        "owner": owner.toJson(),
        "code": code,
        "__v": v,
      };
}
