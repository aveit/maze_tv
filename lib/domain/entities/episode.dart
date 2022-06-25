import 'package:equatable/equatable.dart';
import 'package:maze_tv/domain/entities/image.dart';
import 'package:maze_tv/domain/entities/links.dart';
import 'package:maze_tv/domain/entities/rating.dart';

class Episode extends Equatable {
  const Episode({
    required this.id,
    required this.url,
    required this.name,
    required this.season,
    required this.number,
    required this.type,
    required this.airdate,
    required this.airtime,
    required this.airstamp,
    required this.runtime,
    required this.rating,
    required this.image,
    required this.summary,
    required this.links,
  });

  final int id;
  final String url;
  final String name;
  final int season;
  final int number;
  final String type;
  final String airdate;
  final String airtime;
  final String airstamp;
  final int runtime;
  final Rating rating;
  final TVImage image;
  final String summary;
  final Links links;

  String get shortName {
    if (name.length >= 20) {
      return '${name.substring(0, 20)}...';
    }
    return name;
  }

  @override
  List<Object?> get props => [
        id,
        url,
        name,
        season,
        number,
        type,
        airdate,
        airtime,
        airstamp,
        runtime,
        rating,
        image,
        summary,
        links,
      ];
}
