// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) {
  return Detail()
    ..id = json['id'] as int
    ..homework = json['Homework'] == null
        ? null
        : HomeworkInfo.fromJson(json['Homework'] as Map<String, dynamic>)
    ..score = json['score'];
}

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'id': instance.id,
      'Homework': instance.homework,
      'score': instance.score,
    };
