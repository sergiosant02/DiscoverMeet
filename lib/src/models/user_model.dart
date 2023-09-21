// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
import 'dart:developer' as dev;

import 'dart:convert';

import 'package:discover_meet/src/models/blood_types_enum.dart';
import 'package:discover_meet/src/models/file_model.dart';
import 'package:discover_meet/src/models/genre_enum.dart';
import 'package:discover_meet/src/models/json_convert_interface.dart';
import 'package:discover_meet/src/utils/utils.dart';

class UserModel implements JsonConvertInterface {
  String? id;
  String plan;
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String role;
  Genre genre;
  BloodType blood;
  DateTime birthDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  FileModel? picture;

  UserModel({
    this.id,
    required this.plan,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.genre,
    required this.blood,
    required this.birthDate,
    this.createdAt,
    this.updatedAt,
    this.picture,
  });

  static UserModel createEmptyUser() {
    return UserModel(
        plan: "free",
        firstName: "",
        lastName: "",
        email: "",
        password: "",
        phone: "",
        role: "user",
        genre: Genre.MALE,
        blood: BloodType.AP,
        birthDate: DateTime.now());
  }

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        role: json["role"],
        plan: json["plan"],
        genre: Genre.fromString(json["genre"]),
        blood: json["blood"] != null
            ? BloodType.fromString(json["blood"])
            : BloodType.OL,
        birthDate: DateTime.parse(json["birthDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        picture: (json["picture"] != null && json["picture"] != "")
            ? FileModel.fromJson(json["picture"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "plan": plan,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        "genre": Genre.getString(genre),
        "blood": blood.toString().split(".")[1],
        "birthDate": birthDate.toIso8601String(),
        "createdAt": createdAt != null ? createdAt!.toIso8601String() : '',
        "updateAt": updatedAt != null ? updatedAt!.toIso8601String() : '',
        "picture": picture != null ? picture!.toJson() : ''
      };

  static List<UserModel> fromJsonList(String body) {
    body = Utils.formatJson(body);
    List<UserModel> res = [];
    dynamic decodedData = json.decode(body);
    try {
      for (var map in decodedData) {
        Map<String, dynamic> info = map;
        UserModel user = UserModel.fromJson(info);
        res.add(user);
      }
    } catch (e) {
      dev.log("Error: $e");
    }
    return res;
  }
}
