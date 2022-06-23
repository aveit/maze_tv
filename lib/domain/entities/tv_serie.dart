import 'package:equatable/equatable.dart';

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
  final Image image;
  final String summary;
  final int updated;
  final Links links;

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

class Rating extends Equatable {
  const Rating({required this.average});

  factory Rating.empty() {
    return const Rating(average: 0);
  }

  final double average;

  @override
  List<Object?> get props => [average];
}

class Network extends Equatable {
  const Network({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  factory Network.empty() {
    return Network(
      id: 0,
      name: '',
      country: Country.empty(),
      officialSite: '',
    );
  }

  final int id;
  final String name;
  final Country country;
  final String officialSite;

  @override
  List<Object?> get props => [id, name, country, officialSite];
}

class Country extends Equatable {
  const Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.empty() {
    return const Country(name: '', code: '', timezone: '');
  }

  final String name;
  final String code;
  final String timezone;

  @override
  List<Object?> get props => [name, code, timezone];
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

class Image extends Equatable {
  const Image({required this.medium, required this.original});

  factory Image.empty() {
    return const Image(
      medium: '',
      original: '',
    );
  }

  final String medium;
  final String original;

  @override
  List<Object?> get props => [medium, original];
}

class Links extends Equatable {
  const Links({required this.self, required this.previousepisode});

  factory Links.empty() {
    return Links(
      self: Self.empty(),
      previousepisode: Self.empty(),
    );
  }

  final Self self;
  final Self previousepisode;

  @override
  List<Object?> get props => [self, previousepisode];
}

class Self extends Equatable {
  const Self({required this.href});

  factory Self.empty() {
    return const Self(href: '');
  }

  final String href;

  @override
  List<Object?> get props => [href];
}
