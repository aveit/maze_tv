import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/entities/episode.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/errors/failures.dart';

abstract class GetSeasonEpisodes {
  Future<Either<Failure, List<Episode>>> call({
    required SerieSeason season,
  });
}
