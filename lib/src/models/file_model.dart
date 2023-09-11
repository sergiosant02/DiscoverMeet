import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  @JsonKey(name: "path")
  String path;
  @JsonKey(name: "fileName")
  String fileName;

  FileModel({
    required this.path,
    required this.fileName,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
