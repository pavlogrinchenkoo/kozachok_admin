// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class OfferGuestModel {
  String? id;
  DateTime? date;
  String? name;
  String? contact;
  String? shortStory;


  OfferGuestModel({this.id, this.date, this.name, this.contact, this.shortStory});

  factory OfferGuestModel.fromJson(Map<String, dynamic> json) =>
      _$OfferGuestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferGuestModelToJson(this);
}