import 'package:json_annotation/json_annotation.dart';
import 'course.dart';

part 'courses.g.dart';

@JsonSerializable()
class Courses {
  Courses();

  List<Course> results;

  factory Courses.fromJson(Map<String, dynamic> json) =>
      _$CoursesFromJson(json);
  Map<String, dynamic> toJson() => _$CoursesToJson(this);
}
