import 'package:json_annotation/json_annotation.dart';
import 'homework.dart';

part 'homeworks.g.dart';

@JsonSerializable()
class Homeworks {
  Homeworks();

  List<Homework> results;

  factory Homeworks.fromJson(Map<String, dynamic> json) =>
      _$HomeworksFromJson(json);
  Map<String, dynamic> toJson() => _$HomeworksToJson(this);
}
