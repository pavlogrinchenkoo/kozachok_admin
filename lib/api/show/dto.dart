// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class ShowModel {
  String? id;
  DateTime? date;
  String? title;
  String? description;
  String? photo;
  String? audio;
  DateTime? theDateOfThe;

  ShowModel({
    this.id,
    this.date,
    this.title,
    this.description,
    this.photo,
    this.audio,
    this.theDateOfThe,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) =>
      _$ShowModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowModelToJson(this);
}
