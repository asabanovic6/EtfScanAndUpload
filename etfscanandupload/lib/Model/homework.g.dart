// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Homework _$HomeworkFromJson(Map<String, dynamic> json) {
  return Homework()
    ..id = json['id'] as int
    ..homework = json['Homework'] == null
        ? null
        : HomeworkInfo.fromJson(json['Homework'] as Map<String, dynamic>)
    ..assignNo = json['assignNo'] as int
    ..student = json['student'] == null
        ? null
        : Person.fromJson(json['student'] as Map<String, dynamic>)
    ..status = json['status'] as int
    ..score = json['score']
    ..time = json['time'] as String
    ..comment = json['comment'] as String
    ..compileReport = json['compileReport'] as String
    ..filename = json['filename'] as String
    ..author = json['author'] == null
        ? null
        : Person.fromJson(json['author'] as Map<String, dynamic>)
    ..filesize = json['filesize'] as String
    ..filetype = json['filetype'] as String;
}

Map<String, dynamic> _$HomeworkToJson(Homework instance) => <String, dynamic>{
      'id': instance.id,
      'Homework': instance.homework,
      'assignNo': instance.assignNo,
      'student': instance.student,
      'status': instance.status,
      'score': instance.score,
      'time': instance.time,
      'comment': instance.comment,
      'compileReport': instance.compileReport,
      'filename': instance.filename,
      'author': instance.author,
      'filesize': instance.filesize,
      'filetype': instance.filetype,
    };
