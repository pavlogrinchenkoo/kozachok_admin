// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class BugModel {
  String? id;
  DateTime? date;
  String? contact;
  String? desc;

  BugModel({this.id, this.date, this.contact, this.desc});

  factory BugModel.fromJson(Map<String, dynamic> json) =>
      _$BugModelFromJson(json);

  Map<String, dynamic> toJson() => _$BugModelToJson(this);
}
