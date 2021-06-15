// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course()
    ..courseOffering = json['CourseOffering'] == null
        ? null
        : CourseOffering.fromJson(
            json['CourseOffering'] as Map<String, dynamic>)
    ..score = (json['score'] as List)
        ?.map(
            (e) => e == null ? null : Score.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..student = json['student'] == null
        ? null
        : Person.fromJson(json['student'] as Map<String, dynamic>)
    ..activities = json['activities']
    ..totalScore = json['totalScore']
    ..possibleScore = json['possibleScore']
    ..percent = json['percent']
    ..grade = json['grade']
    ..gradeDate = json['gradeDate'];
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'CourseOffering': instance.courseOffering,
      'score': instance.score,
      'student': instance.student,
      'activities': instance.activities,
      'totalScore': instance.totalScore,
      'possibleScore': instance.possibleScore,
      'percent': instance.percent,
      'grade': instance.grade,
      'gradeDate': instance.gradeDate,
    };
