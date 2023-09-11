import 'package:discover_meet/src/models/json_convert_interface.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'Option_model.g.dart';

@JsonSerializable()
class OptionModel implements JsonConvertInterface {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "opt")
  String opt;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  OptionModel({
    this.id,
    required this.opt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) =>
      _$OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionModelToJson(this);
}
