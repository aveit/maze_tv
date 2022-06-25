import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/episode_model.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/episode.dart';
import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/usecases/get_season_episodes.dart';

class GetSeasonsEpisodesRemote implements GetSeasonEpisodes {
  const GetSeasonsEpisodesRemote(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, List<Episode>>> call(
      {required SerieSeason season}) async {
    try {
      final response = await _apiClient.get(
        path: '/seasons/${season.id}/episodes',
      );
      final episodes = (response as List)
          .map(
            (json) => EpisodeModel.fromJson(
              json as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList();
      return Right(episodes);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
