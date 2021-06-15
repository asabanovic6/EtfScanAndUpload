// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Courses _$CoursesFromJson(Map<String, dynamic> json) {
  return Courses()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Course.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CoursesToJson(Courses instance) => <String, dynamic>{
      'results': instance.results,
    };
