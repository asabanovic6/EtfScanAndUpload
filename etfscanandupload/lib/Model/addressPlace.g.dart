// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressPlace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressPlace _$AddressPlaceFromJson(Map<String, dynamic> json) {
  return AddressPlace()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..country = json['country'] as String
    ..municipality = json['municipality'] as String;
}

Map<String, dynamic> _$AddressPlaceToJson(AddressPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'municipality': instance.municipality,
    };
