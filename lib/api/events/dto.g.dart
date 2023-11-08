// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      isPaid: json['isPaid'] as bool?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      theDateOfThe: json['theDateOfThe'] == null
          ? null
          : DateTime.parse(json['theDateOfThe'] as String),
      eventPlace: json['eventPlace'] as String?,
      contact: json['contact'] as String?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'isPaid': instance.isPaid,
      'image': instance.image,
      'name': instance.name,
      'desc': instance.desc,
      'theDateOfThe': instance.theDateOfThe?.toIso8601String(),
      'eventPlace': instance.eventPlace,
      'contact': instance.contact,
      'status': _$EventStatusEnumMap[instance.status],
    };

const _$EventStatusEnumMap = {
  EventStatus.moderation: 'moderation',
  EventStatus.active: 'active',
  EventStatus.blocked: 'blocked',
  EventStatus.noActive: 'noActive',
};
