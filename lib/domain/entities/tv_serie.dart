import 'package:equatable/equatable.dart';
import 'package:maze_tv/domain/entities/image.dart';
import 'package:maze_tv/domain/entities/links.dart';
import 'package:maze_tv/domain/entities/network.dart';
import 'package:maze_tv/domain/entities/rating.dart';

class TVSerie extends Equatable {
  const TVSerie({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.averageRuntime,
    required this.premiered,
    required this.ended,
    required this.officialSite,
    required this.schedule,
    required this.rating,
    required this.weight,
    required this.network,
    required this.externals,
    required this.image,
    required this.summary,
    required this.updated,
    required this.links,
  });

  factory TVSerie.empty({
    int? id,
    String? url,
    String? name,
    String? type,
    String? language,
    List<String>? genres,
    String? status,
    int? runtime,
    int? averageRuntime,
    String? premiered,
    String? ended,
    String? officialSite,
    Schedule? schedule,
    Rating? rating,
    int? weight,
    Network? network,
    Externals? externals,
    TVImage? image,
    String? summary,
    int? updated,
    Links? links,
  }) {
    return TVSerie(
      id: id ?? 1,
      url: url ?? '',
      name: name ?? '',
      type: type ?? '',
      language: language ?? '',
      genres: genres ?? const [''],
      status: status ?? '',
      runtime: runtime ?? 0,
      averageRuntime: averageRuntime ?? 0,
      premiered: premiered ?? '',
      ended: ended ?? '',
      officialSite: officialSite ?? '',
      schedule: schedule ?? Schedule.empty(),
      rating: rating ?? Rating.empty(),
      weight: weight ?? 0,
      network: network ?? Network.empty(),
      externals: externals ?? Externals.empty(),
      image: image ?? TVImage.empty(),
      summary: summary ?? '',
      updated: updated ?? 0,
      links: links ?? Links.empty(),
    );
  }

  final int id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final int runtime;
  final int averageRuntime;
  final String premiered;
  final String ended;
  final String officialSite;
  final Schedule schedule;
  final Rating rating;
  final int weight;
  final Network network;
  final Externals externals;
  final TVImage image;
  final String summary;
  final int updated;
  final Links links;

  bool get containsImage {
    return image.medium.isNotEmpty || image.original.isNotEmpty;
  }

  String? get imageUrl {
    if (containsImage) {
      if (image.medium.isNotEmpty) {
        return image.medium;
      }
      return image.original;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        id,
        url,
        name,
        type,
        language,
        genres,
        status,
        runtime,
        averageRuntime,
        premiered,
        ended,
        officialSite,
        schedule,
        rating,
        weight,
        network,
        externals,
        image,
        summary,
        updated,
        links,
      ];
}

class Schedule extends Equatable {
  const Schedule({
    required this.time,
    required this.days,
  });

  factory Schedule.empty() {
    return const Schedule(time: '', days: []);
  }

  final String time;
  final List<String> days;

  @override
  List<Object?> get props => [time, days];
}

class Externals extends Equatable {
  const Externals({
    required this.tvrage,
    required this.thetvdb,
    required this.imdb,
  });

  factory Externals.empty() {
    return const Externals(imdb: '', thetvdb: 0, tvrage: 0);
  }

  final int tvrage;
  final int thetvdb;
  final String imdb;

  @override
  List<Object?> get props => [tvrage, thetvdb, imdb];
}
