// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..surname = json['surname'] as String
    ..login = json['login'] as String
    ..hasPhoto = json['hasPhoto'] as bool
    ..titlesPre = json['titlesPre'] as String
    ..titlesPost = json['titlesPost'] as String
    ..extendedPerson = json['ExtendedPerson'] == null
        ? null
        : ExtendedPerson.fromJson(
            json['ExtendedPerson'] as Map<String, dynamic>)
    ..rSS = json['RSS'] == null
        ? null
        : Rss.fromJson(json['RSS'] as Map<String, dynamic>)
    ..lastAccess = json['lastAccess'] as String;
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'login': instance.login,
      'hasPhoto': instance.hasPhoto,
      'titlesPre': instance.titlesPre,
      'titlesPost': instance.titlesPost,
      'ExtendedPerson': instance.extendedPerson,
      'RSS': instance.rSS,
      'lastAccess': instance.lastAccess,
    };
