import 'package:json_annotation/json_annotation.dart';

part 'addressPlace.g.dart';

@JsonSerializable()
class AddressPlace {
  AddressPlace();

  int id;
  String name;
  String country;
  String municipality;

  factory AddressPlace.fromJson(Map<String, dynamic> json) =>
      _$AddressPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$AddressPlaceToJson(this);
}
