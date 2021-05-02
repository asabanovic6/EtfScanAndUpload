import 'package:json_annotation/json_annotation.dart';

part 'rss.g.dart';

@JsonSerializable()
class Rss {
  Rss();

  String id;
  int personId;

  factory Rss.fromJson(Map<String, dynamic> json) => _$RssFromJson(json);
  Map<String, dynamic> toJson() => _$RssToJson(this);
}
