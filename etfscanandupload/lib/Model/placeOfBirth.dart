import 'package:json_annotation/json_annotation.dart';

part 'placeOfBirth.g.dart';

@JsonSerializable()
class PlaceOfBirth {
  PlaceOfBirth();

  int id;
  String name;
  String country;
  String municipality;

  factory PlaceOfBirth.fromJson(Map<String, dynamic> json) =>
      _$PlaceOfBirthFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceOfBirthToJson(this);
}
