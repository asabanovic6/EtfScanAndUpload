import 'package:json_annotation/json_annotation.dart';

import 'homeworkInfo.dart';
part 'detail.g.dart';

@JsonSerializable()
class Detail {
  Detail();

  int id;
  @JsonKey(name: 'Homework')
  HomeworkInfo homework;
  dynamic score;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
