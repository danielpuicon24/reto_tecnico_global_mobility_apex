import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/country.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  final String code;
  final String name;
  final String emoji;

  const CountryModel({
    required this.code,
    required this.name,
    required this.emoji,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  Country toEntity() {
    return Country(
      code: code,
      name: name,
      emoji: emoji,
    );
  }

  factory CountryModel.fromEntity(Country country) {
    return CountryModel(
      code: country.code,
      name: country.name,
      emoji: country.emoji,
    );
  }
}
