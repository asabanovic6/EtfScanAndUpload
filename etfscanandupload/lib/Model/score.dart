import 'package:json_annotation/json_annotation.dart';
import 'package:etfscanandupload/Model/courseActivity.dart';
import 'package:etfscanandupload/Model/detail.dart';

part 'score.g.dart';

@JsonSerializable()
class Score {
  Score();

  @JsonKey(name: 'CourseActivity')
  CourseActivity courseActivity;
  dynamic score;
  List<Detail> details;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}
