// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeOfBirth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOfBirth _$PlaceOfBirthFromJson(Map<String, dynamic> json) {
  return PlaceOfBirth()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..country = json['country'] as String
    ..municipality = json['municipality'] as String;
}

Map<String, dynamic> _$PlaceOfBirthToJson(PlaceOfBirth instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'municipality': instance.municipality,
    };
