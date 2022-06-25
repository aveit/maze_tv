import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_season_episodes.dart';
import 'package:maze_tv/domain/usecases/get_serie_seasons.dart';

class GetSeasonsWithEpisodes implements GetSerieSeasons {
  const GetSeasonsWithEpisodes({
    required this.getSeasons,
    required this.getEpisodes,
  });

  final GetSerieSeasons getSeasons;
  final GetSeasonEpisodes getEpisodes;

  @override
  Future<Either<Failure, List<SerieSeason>>> call({
    required TVSerie serie,
  }) async {
    final seasonsOrFailure = await getSeasons(serie: serie);
    final seasonsWithEpisodes = <SerieSeason>[];

    return seasonsOrFailure.fold(
      left,
      (seasons) async {
        for (final season in seasons) {
          final episodesOrFailure = await getEpisodes(season: season);
          final episodes = episodesOrFailure.getOrElse(() => []);
          seasonsWithEpisodes.add(season.copyWith(episodes: episodes));
        }
        return right(seasonsWithEpisodes);
      },
    );
  }
}
