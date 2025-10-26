// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
  id: json['id'] as String?,
  url: json['url'] as String?,
  breeds: (json['breeds'] as List<dynamic>?)
      ?.map((e) => e as Map<String, dynamic>)
      .toList(),
  gender: json['gender'] as String?,
  distance: json['distance'] as String?,
);

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'breeds': instance.breeds,
  'gender': instance.gender,
  'distance': instance.distance,
};
