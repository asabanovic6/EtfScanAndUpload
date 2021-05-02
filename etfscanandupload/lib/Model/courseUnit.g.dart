// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courseUnit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseUnit _$CourseUnitFromJson(Map<String, dynamic> json) {
  return CourseUnit()
    ..id = json['id'] as int
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..abbrev = json['abbrev'] as String;
}

Map<String, dynamic> _$CourseUnitToJson(CourseUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'abbrev': instance.abbrev,
    };
