// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferGuestModel _$OfferGuestModelFromJson(Map<String, dynamic> json) =>
    OfferGuestModel(
      id: json['id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      shortStory: json['shortStory'] as String?,
    );

Map<String, dynamic> _$OfferGuestModelToJson(OfferGuestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'name': instance.name,
      'contact': instance.contact,
      'shortStory': instance.shortStory,
    };
