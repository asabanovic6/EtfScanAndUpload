// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return Score()
    ..courseActivity = json['CourseActivity'] == null
        ? null
        : CourseActivity.fromJson(
            json['CourseActivity'] as Map<String, dynamic>)
    ..score = json['score']
    ..details = (json['details'] as List)
        ?.map((e) =>
            e == null ? null : Detail.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'CourseActivity': instance.courseActivity,
      'score': instance.score,
      'details': instance.details,
    };
