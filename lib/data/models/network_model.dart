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
}
