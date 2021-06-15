import 'package:json_annotation/json_annotation.dart';

part 'ZClass.g.dart';

@JsonSerializable()
class ZClass {
  ZClass();

  String dateTime;

  factory ZClass.fromJson(Map<String, dynamic> json) => _$ZClassFromJson(json);
  Map<String, dynamic> toJson() => _$ZClassToJson(this);
}
