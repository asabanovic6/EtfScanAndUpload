import 'package:etfscanandupload/Model/academicYear.dart';
import 'package:json_annotation/json_annotation.dart';
import 'courseUnit.dart';

part 'courseOffering.g.dart';

@JsonSerializable()
class CourseOffering {
  CourseOffering();

  int id;
  @JsonKey(name: 'CourseUnit')
  CourseUnit courseUnit;
  @JsonKey(name: 'AcademicYear')
  AcademicYear academicYear;
  int semester;
  bool mandatory;

  factory CourseOffering.fromJson(Map<String, dynamic> json) =>
      _$CourseOfferingFromJson(json);
  Map<String, dynamic> toJson() => _$CourseOfferingToJson(this);
}
