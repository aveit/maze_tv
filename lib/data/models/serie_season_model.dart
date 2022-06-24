import 'package:maze_tv/data/models/image_model.dart';
import 'package:maze_tv/data/models/network_model.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';

class SerieSeasonModel {
  const SerieSeasonModel({
    this.id,
    this.url,
    this.number,
    this.name,
    this.episodeOrder,
    this.premiereDate,
    this.endDate,
    this.network,
    this.image,
    this.summary,
    this.links,
  });

  factory SerieSeasonModel.fromJson(Map<String, dynamic> json) {
    return SerieSeasonModel(
      id: json['id'] as int?,
      url: json['url'] as String?,
      number: json['number'] as int?,
      name: json['name'] as String?,
      episodeOrder: json['episodeOrder'] as int?,
      premiereDate: json['premiereDate'] as String?,
      endDate: json['endDate'] as String?,
      network: json['network'] != null
          ? NetworkModel.fromJson(json['network'] as Map<String, dynamic>)
          : null,
      image: json['image'] != null
          ? TVImageModel.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      summary: json['summary'] as String?,
      links: json['_links'] != null
          ? LinksModel.fromJson(json['_links'] as Map<String, dynamic>)
          : null,
    );
  }

  final int? id;
  final String? url;
  final int? number;
  final String? name;
  final int? episodeOrder;
  final String? premiereDate;
  final String? endDate;
  final String? summary;
  final NetworkModel? network;
  final TVImageModel? image;
  final LinksModel? links;
}
