// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class UserModel {
  String id;
  String plan;
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String role;
  String genre;
  String blood;
  DateTime createdAt;
  DateTime updateAt;

  UserModel({
    required this.id,
    required this.plan,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.genre,
    required this.blood,
    required this.createdAt,
    required this.updateAt,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        plan: json["plan"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        role: json["role"],
        genre: json["genre"],
        blood: json["blood"],
        createdAt: DateTime.parse(json["createdAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
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
        "genre": genre,
        "blood": blood,
        "createdAt": createdAt.toIso8601String(),
        "updateAt": updateAt.toIso8601String(),
      };
}
