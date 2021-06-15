import 'package:json_annotation/json_annotation.dart';
part 'academicYear.g.dart';

@JsonSerializable()
class AcademicYear {
  AcademicYear();

  int id;
  String name;
  factory AcademicYear.fromJson(Map<String, dynamic> json) =>
      _$AcademicYearFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicYearToJson(this);
}
