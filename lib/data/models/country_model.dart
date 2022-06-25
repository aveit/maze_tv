import 'dart:convert';

import 'package:maze_tv/domain/entities/country.dart';

class CountryModel {
  const CountryModel({
    this.name,
    this.code,
    this.timezone,
  });
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] as String?,
      code: json['code'] as String?,
      timezone: json['timezone'] as String?,
    );
  }

  final String? name;
  final String? code;
  final String? timezone;

  Country toEntity() {
    return Country(
      name: name ?? '',
      code: code ?? '',
      timezone: timezone ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (timezone != null) {
      result.addAll({'timezone': timezone});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
