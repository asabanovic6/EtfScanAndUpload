import 'package:json_annotation/json_annotation.dart';
import 'homeworkInfo.dart';
part 'homeworksInfo.g.dart';

@JsonSerializable()
class HomeworksInfo {
  HomeworksInfo();

  List<HomeworkInfo> results;

  factory HomeworksInfo.fromJson(Map<String, dynamic> json) =>
      _$HomeworksInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HomeworksInfoToJson(this);
}
