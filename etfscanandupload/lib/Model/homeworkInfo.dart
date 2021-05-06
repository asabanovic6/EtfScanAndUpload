import 'package:json_annotation/json_annotation.dart';
import 'package:etfscanandupload/Model/courseUnit.dart';

part 'homeworkInfo.g.dart';

@JsonSerializable()
class HomeworkInfo {
  HomeworkInfo();

  int id;
  String name;
   @JsonKey(name: 'CourseUnit')
  CourseUnit courseUnit;
  int nrAssignments;
  dynamic maxScore;
  String deadline;
  bool active;
  bool automatedTesting;
  bool attachment;
  String allowedExtensions;
  String publishedDateTime;
  bool readonly;

  factory HomeworkInfo.fromJson(Map<String, dynamic> json) =>
      _$HomeworkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HomeworkInfoToJson(this);
}
