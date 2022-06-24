import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';

abstract class GetSerieSeasons {
  Future<Either<Failure, List<SerieSeason>>> call({
    required TVSerie serie,
  });
}
