import 'package:json_annotation/json_annotation.dart';

part 'courseActivity.g.dart';

@JsonSerializable()
class CourseActivity {
  CourseActivity();

  int id;
  String name;
  String abbrev;
  dynamic points;
  dynamic pass;

  factory CourseActivity.fromJson(Map<String, dynamic> json) =>
      _$CourseActivityFromJson(json);
  Map<String, dynamic> toJson() => _$CourseActivityToJson(this);
}
