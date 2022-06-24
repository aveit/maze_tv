import 'package:dartz/dartz.dart';
import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/serie_season_model.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_serie_seasons.dart';

class GetSerieSeasonsRemote implements GetSerieSeasons {
  GetSerieSeasonsRemote(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, List<SerieSeason>>> call({
    required TVSerie serie,
  }) async {
    try {
      final response = await _apiClient.get(
        path: '/shows/${serie.id}/seasons',
      );
      final seasons = (response as List)
          .map(
            (json) => SerieSeasonModel.fromJson(
              json as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList();
      return Right(seasons);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
