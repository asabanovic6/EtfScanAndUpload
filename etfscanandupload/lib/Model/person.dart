import 'package:json_annotation/json_annotation.dart';
import 'rss.dart';
import 'extendedPerson.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  Person();

  int id;
  String name;
  String surname;
  String login;
  bool hasPhoto;
  String titlesPre;
  String titlesPost;
  
  @JsonKey(name: 'ExtendedPerson')
  ExtendedPerson extendedPerson;
  @JsonKey(name: 'RSS')
  Rss rSS;
  String lastAccess;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
