import 'package:maze_tv/data/models/image_model.dart';
import 'package:maze_tv/data/models/rating_model.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/domain/entities/episode.dart';
import 'package:maze_tv/domain/entities/image.dart';
import 'package:maze_tv/domain/entities/links.dart';
import 'package:maze_tv/domain/entities/rating.dart';

class EpisodeModel {
  EpisodeModel({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.type,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.rating,
    this.image,
    this.summary,
    this.links,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      season: json['season'] as int?,
      number: json['number'] as int?,
      type: json['type'] as String?,
      airdate: json['airdate'] as String?,
      airtime: json['airtime'] as String?,
      airstamp: json['airstamp'] as String?,
      runtime: json['runtime'] as int?,
      rating: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      image: TVImageModel.fromJson(json['image'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
      links: LinksModel.fromJson(json['_links'] as Map<String, dynamic>),
    );
  }

  Episode toEntity() {
    return Episode(
      id: id ?? 0,
      url: url ?? '',
      name: name ?? '',
      season: season ?? 0,
      number: number ?? 0,
      type: type ?? '',
      airdate: airdate ?? '',
      airtime: airtime ?? '',
      airstamp: airstamp ?? '',
      runtime: runtime ?? 0,
      rating: rating?.toEntity() ?? Rating.empty(),
      image: image?.toEntity() ?? TVImage.empty(),
      summary: summary ?? '',
      links: links?.toEntity() ?? Links.empty(),
    );
  }

  final int? id;
  final String? url;
  final String? name;
  final int? season;
  final int? number;
  final String? type;
  final String? airdate;
  final String? airtime;
  final String? airstamp;
  final int? runtime;
  final RatingModel? rating;
  final TVImageModel? image;
  final String? summary;
  final LinksModel? links;
}
