import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/usecases/search_series_by_name.dart';

class SearchSeriesByNameRemote implements SearchSeriesByName {
  SearchSeriesByNameRemote(this._apiClient);

  final ApiClient _apiClient;
  static const path = '/search/shows';

  @override
  Future<Either<Failure, List<TVSerie>>> call({
    required String serieName,
  }) async {
    await _apiClient.get(path: path, queryParams: {'q': serieName});
    return left(ServerFailure());
  }
}
