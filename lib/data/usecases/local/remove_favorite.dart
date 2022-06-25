import 'package:dartz/dartz.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/local_storage/local_storage_client.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/remove_favorite.dart';

class RemoveFavoriteLocal implements RemoveFavorite {
  RemoveFavoriteLocal(this._storage);

  final LocalStorageClient _storage;
  static const key = 'favorites';

  @override
  Future<Either<Failure, Unit>> call(TVSerie serie) async {
    try {
      final stored = await _storage.get(key: key);
      if (stored == null) {
        return right(unit);
      }

      final favs = (stored as List<dynamic>).map((jsonMap) {
        return TvSerieModel.fromJson(jsonMap as Map<String, dynamic>);
      }).toList()
        ..removeWhere(
          (fav) => fav == TvSerieModel.fromEntity(serie),
        );

      final updatedFavs = favs.map((e) => e.toJson()).toList();

      await _storage.set(key: key, value: updatedFavs);
      return right(unit);
    } on AppException catch (e) {
      return left(e.toFailure());
    }
  }
}
