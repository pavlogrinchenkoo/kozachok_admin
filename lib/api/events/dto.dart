// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class EventModel {
  String? id;
  DateTime? date;
  bool? isPaid;
  String? image;
  String? name;
  String? desc;
  DateTime? theDateOfThe;
  String? eventPlace;
  String? contact;
  EventStatus? status;

  EventModel(
      {this.id,
      this.date,
      this.isPaid,
      this.image,
      this.name,
      this.desc,
      this.theDateOfThe,
      this.eventPlace,
      this.contact,
      this.status});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}

enum EventStatus { moderation, active, blocked, noActive }
