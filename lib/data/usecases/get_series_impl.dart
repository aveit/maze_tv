import 'package:dartz/dartz.dart';
import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_series.dart';

class GetTVSeriesImpl implements GetSeries {
  const GetTVSeriesImpl({
    required this.apiClient,
  });

  final ApiClient apiClient;
  @override
  Future<Either<Failure, List<TVSerie>>> call() async {
    try {
      final response = await apiClient.get(path: '/shows');
      final series = (response as List<Map<String, dynamic>>)
          .map((json) => TvSerieModel.fromJson(json).toEntity())
          .toList();

      return right(series);
    } on AppException catch (e) {
      return left(e.toFailure());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
