// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extendedPerson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedPerson _$ExtendedPersonFromJson(Map<String, dynamic> json) {
  return ExtendedPerson()
    ..id = json['id'] as int
    ..fathersName = json['fathersName'] as String
    ..fathersSurname = json['fathersSurname'] as String
    ..mothersName = json['mothersName'] as String
    ..mothersSurname = json['mothersSurname'] as String
    ..sex = json['sex'] as String
    ..dateOfBirth = json['dateOfBirth'] as String
    ..placeOfBirth = json['placeOfBirth'] == null
        ? null
        : PlaceOfBirth.fromJson(json['placeOfBirth'] as Map<String, dynamic>)
    ..ethnicity = json['ethnicity'] as int
    ..nationality = json['nationality'] as int
    ..jmbg = json['jmbg'] as int
    ..addressStreetNo = json['addressStreetNo'] as String
    ..addressPlace = json['addressPlace'] == null
        ? null
        : AddressPlace.fromJson(json['addressPlace'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ExtendedPersonToJson(ExtendedPerson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fathersName': instance.fathersName,
      'fathersSurname': instance.fathersSurname,
      'mothersName': instance.mothersName,
      'mothersSurname': instance.mothersSurname,
      'sex': instance.sex,
      'dateOfBirth': instance.dateOfBirth,
      'placeOfBirth': instance.placeOfBirth,
      'ethnicity': instance.ethnicity,
      'nationality': instance.nationality,
      'jmbg': instance.jmbg,
      'addressStreetNo': instance.addressStreetNo,
      'addressPlace': instance.addressPlace,
    };
