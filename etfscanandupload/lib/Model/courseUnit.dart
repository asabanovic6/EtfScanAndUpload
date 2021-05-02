import 'package:json_annotation/json_annotation.dart';

part 'courseUnit.g.dart';

@JsonSerializable()
class CourseUnit {
  CourseUnit();

  int id;
  String code;
  String name;
  String abbrev;

  factory CourseUnit.fromJson(Map<String, dynamic> json) =>
      _$CourseUnitFromJson(json);
  Map<String, dynamic> toJson() => _$CourseUnitToJson(this);
}
