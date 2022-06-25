import 'dart:convert';

import 'package:maze_tv/data/models/country_model.dart';
import 'package:maze_tv/domain/entities/country.dart';
import 'package:maze_tv/domain/entities/network.dart';

class NetworkModel {
  const NetworkModel({
    this.id,
    this.name,
    this.country,
    this.officialSite,
  });

  factory NetworkModel.fromEntity(Network entity) {
    return NetworkModel(
      id: entity.id,
      name: entity.name,
      country: CountryModel.fromEntity(entity.country),
      officialSite: entity.officialSite,
    );
  }

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      country: json['country'] != null
          ? CountryModel.fromJson(json['country'] as Map<String, dynamic>)
          : null,
      officialSite: json['officialSite'] as String?,
    );
  }

  final int? id;
  final String? name;
  final CountryModel? country;
  final String? officialSite;

  Network toEntity() {
    return Network(
      id: id ?? 0,
      name: name ?? '',
      country: country?.toEntity() ?? Country.empty(),
      officialSite: officialSite ?? '',
    );
  }

  NetworkModel copyWith({
    int? id,
    String? name,
    CountryModel? country,
    String? officialSite,
  }) {
    return NetworkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      officialSite: officialSite ?? this.officialSite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (country != null) {
      result.addAll({'country': country!.toMap()});
    }
    if (officialSite != null) {
      result.addAll({'officialSite': officialSite});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
