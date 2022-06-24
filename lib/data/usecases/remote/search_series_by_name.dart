import 'package:dartz/dartz.dart';
import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/search_series_by_name.dart';

class SearchSeriesByNameRemote implements SearchSeriesByName {
  SearchSeriesByNameRemote(this._apiClient);

  final ApiClient _apiClient;
  static const path = '/search/shows';

  @override
  Future<Either<Failure, List<TVSerie>>> call({
    required String serieName,
  }) async {
    if (serieName.isEmpty) {
      return const Left(InvalidParamFailure());
    }

    try {
      final response =
          await _apiClient.get(path: path, queryParams: {'q': serieName});
      final series = (response as List)
          .map(
            (json) => TvSerieModel.fromJson(
              json['show'] as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList();

      return Right(series);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
