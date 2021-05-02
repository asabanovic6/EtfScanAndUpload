// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeworks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Homeworks _$HomeworksFromJson(Map<String, dynamic> json) {
  return Homeworks()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Homework.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeworksToJson(Homeworks instance) => <String, dynamic>{
      'results': instance.results,
    };
