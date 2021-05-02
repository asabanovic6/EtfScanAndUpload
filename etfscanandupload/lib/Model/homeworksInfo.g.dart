// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeworksInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeworksInfo _$HomeworksInfoFromJson(Map<String, dynamic> json) {
  return HomeworksInfo()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : HomeworkInfo.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeworksInfoToJson(HomeworksInfo instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
