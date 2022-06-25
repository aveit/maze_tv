import 'package:dartz/dartz.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/local_storage/local_storage_client.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_favorites.dart';

class GetFavoritesLocal implements GetFavorites {
  GetFavoritesLocal(this._storage);

  final LocalStorageClient _storage;

  static const key = 'favorites';

  @override
  Future<Either<Failure, List<TVSerie>>> call() async {
    try {
      final favorites = await _storage.get(key: key);
      if (favorites == null) {
        return right([]);
      }
      return right(_mapToEntity(favorites as List<dynamic>));
    } on AppException catch (e) {
      return left(e.toFailure());
    }
  }

  List<TVSerie> _mapToEntity(List<dynamic> jsonList) {
    return jsonList.map<TVSerie>(
      (json) {
        return TvSerieModel.fromJson(json as Map<String, dynamic>).toEntity();
      },
    ).toList();
  }
}
