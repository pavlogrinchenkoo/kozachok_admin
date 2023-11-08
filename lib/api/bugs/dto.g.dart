// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BugModel _$BugModelFromJson(Map<String, dynamic> json) => BugModel(
      id: json['id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      contact: json['contact'] as String?,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$BugModelToJson(BugModel instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'contact': instance.contact,
      'desc': instance.desc,
    };
