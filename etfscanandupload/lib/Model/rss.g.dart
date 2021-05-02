// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rss.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rss _$RssFromJson(Map<String, dynamic> json) {
  return Rss()
    ..id = json['id'] as String
    ..personId = json['personId'] as int;
}

Map<String, dynamic> _$RssToJson(Rss instance) => <String, dynamic>{
      'id': instance.id,
      'personId': instance.personId,
    };
