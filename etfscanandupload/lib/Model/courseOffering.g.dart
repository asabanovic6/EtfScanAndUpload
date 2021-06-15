// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courseOffering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseOffering _$CourseOfferingFromJson(Map<String, dynamic> json) {
  return CourseOffering()
    ..id = json['id'] as int
    ..courseUnit = json['CourseUnit'] == null
        ? null
        : CourseUnit.fromJson(json['CourseUnit'] as Map<String, dynamic>)
    ..academicYear = json['AcademicYear'] == null
        ? null
        : AcademicYear.fromJson(json['AcademicYear'] as Map<String, dynamic>)
    ..semester = json['semester'] as int
    ..mandatory = json['mandatory'] as bool;
}

Map<String, dynamic> _$CourseOfferingToJson(CourseOffering instance) =>
    <String, dynamic>{
      'id': instance.id,
      'CourseUnit': instance.courseUnit,
      'AcademicYear': instance.academicYear,
      'semester': instance.semester,
      'mandatory': instance.mandatory,
    };
