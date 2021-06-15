import 'package:etfscanandupload/Model/score.dart';
import 'package:json_annotation/json_annotation.dart';
import 'courseOffering.dart';
import 'person.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  Course();

  @JsonKey(name: 'CourseOffering')
  CourseOffering courseOffering;
  @JsonKey(name: 'score')
  List<Score> score;
  Person student;
  dynamic activities;
  dynamic totalScore;
  dynamic possibleScore;
  dynamic percent;
  dynamic grade;
  dynamic gradeDate;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
