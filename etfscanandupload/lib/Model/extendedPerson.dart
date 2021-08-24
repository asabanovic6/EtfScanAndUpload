import 'package:json_annotation/json_annotation.dart';
import 'placeOfBirth.dart';
import 'addressPlace.dart';

part 'extendedPerson.g.dart';

@JsonSerializable()
class ExtendedPerson {
  ExtendedPerson();

  int id;
  String fathersName;
  String fathersSurname;
  String mothersName;
  String mothersSurname;
  String sex;
  String dateOfBirth;
  PlaceOfBirth placeOfBirth;
  int ethnicity;
  int nationality;
  int jmbg;
  String addressStreetNo;
  AddressPlace addressPlace;

  factory ExtendedPerson.fromJson(Map<String, dynamic> json) =>
      _$ExtendedPersonFromJson(json);
  Map<String, dynamic> toJson() => _$ExtendedPersonToJson(this);
}
