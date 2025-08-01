// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
  code: json['code'] as String,
  name: json['name'] as String,
  emoji: json['emoji'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'emoji': instance.emoji,
      'phone': instance.phone,
    };
