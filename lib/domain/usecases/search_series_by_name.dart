import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';

abstract class SearchSeriesByName {
  Future<Either<Failure, List<TVSerie>>> call({
    required String serieName,
  });
}
