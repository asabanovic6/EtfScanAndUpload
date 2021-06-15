// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courseActivity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseActivity _$CourseActivityFromJson(Map<String, dynamic> json) {
  return CourseActivity()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..abbrev = json['abbrev'] as String
    ..points = json['points']
    ..pass = json['pass'];
}

Map<String, dynamic> _$CourseActivityToJson(CourseActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbrev': instance.abbrev,
      'points': instance.points,
      'pass': instance.pass,
    };
