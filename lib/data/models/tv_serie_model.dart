import 'package:maze_tv/data/models/image_model.dart';
import 'package:maze_tv/data/models/network_model.dart';
import 'package:maze_tv/data/models/rating_model.dart';
import 'package:maze_tv/domain/entities/image.dart';
import 'package:maze_tv/domain/entities/links.dart';
import 'package:maze_tv/domain/entities/network.dart';
import 'package:maze_tv/domain/entities/rating.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';

class TvSerieModel {
  const TvSerieModel({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.externals,
    this.image,
    this.summary,
    this.updated,
    this.lLinks,
  });

  factory TvSerieModel.fromJson(Map<String, dynamic> json) {
    return TvSerieModel(
      id: json['id'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      language: json['language'] as String?,
      genres: (json['genres'] as List<dynamic>?)?.cast<String>(),
      status: json['status'] as String?,
      runtime: json['runtime'] as int?,
      averageRuntime: json['averageRuntime'] as int?,
      premiered: json['premiered'] as String?,
      ended: json['ended'] as String?,
      officialSite: json['officialSite'] as String?,
      schedule: json['schedule'] != null
          ? ScheduleModel.fromJson(json['schedule'] as Map<String, dynamic>)
          : null,
      rating: json['rating'] != null
          ? RatingModel.fromJson(json['rating'] as Map<String, dynamic>)
          : null,
      weight: json['weight'] as int?,
      network: json['network'] != null
          ? NetworkModel.fromJson(json['network'] as Map<String, dynamic>)
          : null,
      externals: json['externals'] != null
          ? ExternalsModel.fromJson(json['externals'] as Map<String, dynamic>)
          : null,
      image: json['image'] != null
          ? TVImageModel.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      summary: json['summary'] as String?,
      updated: json['updated'] as int?,
      lLinks: json['_links'] != null
          ? LinksModel.fromJson(json['_links'] as Map<String, dynamic>)
          : null,
    );
  }

  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final String? language;
  final List<String>? genres;
  final String? status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final ScheduleModel? schedule;
  final RatingModel? rating;
  final int? weight;
  final NetworkModel? network;
  final ExternalsModel? externals;
  final TVImageModel? image;
  final String? summary;
  final int? updated;
  final LinksModel? lLinks;

  TVSerie toEntity() {
    return TVSerie(
      id: id ?? 0,
      url: url ?? '',
      name: name ?? '',
      type: type ?? '',
      language: language ?? '',
      genres: genres ?? [],
      status: status ?? '',
      runtime: runtime ?? 0,
      averageRuntime: averageRuntime ?? 0,
      premiered: premiered ?? '',
      ended: ended ?? '',
      officialSite: officialSite ?? '',
      schedule: schedule?.toEntity() ??
          const Schedule(
            days: [],
            time: '',
          ),
      rating: rating?.toEntity() ?? Rating.empty(),
      weight: weight ?? 0,
      network: network?.toEntity() ?? Network.empty(),
      externals: externals?.toEntity() ?? Externals.empty(),
      image: image?.toEntity() ?? TVImage.empty(),
      summary: summary ?? '',
      updated: updated ?? 0,
      links: lLinks?.toEntity() ?? Links.empty(),
    );
  }
}

class ScheduleModel {
  const ScheduleModel({this.time, this.days = const []});
  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      time: json['time'] as String?,
      days: (json['days'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }

  final String? time;
  final List<String> days;

  Schedule toEntity() {
    return Schedule(
      days: days,
      time: time ?? '',
    );
  }
}

class ExternalsModel {
  const ExternalsModel({this.tvrage, this.thetvdb, this.imdb});
  factory ExternalsModel.fromJson(Map<String, dynamic> json) {
    return ExternalsModel(
      tvrage: json['tvrage'] as int?,
      thetvdb: json['thetvdb'] as int?,
      imdb: json['imdb'] as String?,
    );
  }

  final int? tvrage;
  final int? thetvdb;
  final String? imdb;

  Externals toEntity() {
    return Externals(
      tvrage: tvrage ?? 0,
      thetvdb: thetvdb ?? 0,
      imdb: imdb ?? '',
    );
  }
}

class LinksModel {
  const LinksModel({this.self, this.previousepisode});
  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      self: json['self'] != null
          ? SelfModel.fromJson(json['self'] as Map<String, dynamic>)
          : null,
      previousepisode: json['previousepisode'] != null
          ? SelfModel.fromJson(json['previousepisode'] as Map<String, dynamic>)
          : null,
    );
  }

  Links toEntity() {
    return Links(
      self: self?.toEntity() ?? Self.empty(),
      previousepisode: previousepisode?.toEntity() ?? Self.empty(),
    );
  }

  final SelfModel? self;
  final SelfModel? previousepisode;
}

class SelfModel {
  const SelfModel({this.href});
  factory SelfModel.fromJson(Map<String, dynamic> json) {
    return SelfModel(href: json['href'] as String?);
  }

  final String? href;

  Self toEntity() {
    return Self(href: href ?? '');
  }
}
