import 'package:json_annotation/json_annotation.dart';
import 'homeworkInfo.dart';
import 'person.dart';

part 'homework.g.dart';

@JsonSerializable()
class Homework {
  Homework();

  int id;
  @JsonKey(name: 'Homework')
  HomeworkInfo homework;
  int assignNo;
  Person student;
  int status;
  dynamic score;
  String time;
  String comment;
  String compileReport;
  String filename;
  Person author;
  String filesize;
  String filetype;

  factory Homework.fromJson(Map<String, dynamic> json) =>
      _$HomeworkFromJson(json);
  Map<String, dynamic> toJson() => _$HomeworkToJson(this);
}
