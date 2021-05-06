// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeworkInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeworkInfo _$HomeworkInfoFromJson(Map<String, dynamic> json) {
  return HomeworkInfo()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..courseUnit = json['CourseUnit'] == null
        ? null
        : CourseUnit.fromJson(json['CourseUnit'] as Map<String, dynamic>)
    ..nrAssignments = json['nrAssignments'] as int
    ..maxScore = json['maxScore']
    ..deadline = json['deadline'] as String
    ..active = json['active'] as bool
    ..automatedTesting = json['automatedTesting'] as bool
    ..attachment = json['attachment'] as bool
    ..allowedExtensions = json['allowedExtensions'] as String
    ..publishedDateTime = json['publishedDateTime'] as String
    ..readonly = json['readonly'] as bool;
}

Map<String, dynamic> _$HomeworkInfoToJson(HomeworkInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'CourseUnit': instance.courseUnit,
      'nrAssignments': instance.nrAssignments,
      'maxScore': instance.maxScore,
      'deadline': instance.deadline,
      'active': instance.active,
      'automatedTesting': instance.automatedTesting,
      'attachment': instance.attachment,
      'allowedExtensions': instance.allowedExtensions,
      'publishedDateTime': instance.publishedDateTime,
      'readonly': instance.readonly,
    };
