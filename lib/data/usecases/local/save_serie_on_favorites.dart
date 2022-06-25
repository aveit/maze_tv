import 'package:dartz/dartz.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/local_storage/local_storage_client.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/save_serie_on_favorites.dart';

class SaveSerieOnFavoritesLocal implements SaveSerieOnFavorites {
  SaveSerieOnFavoritesLocal(this._storage);

  final LocalStorageClient _storage;

  static const key = 'favorites';

  @override
  Future<Either<Failure, Unit>> call(TVSerie serie) async {
    try {
      final model = TvSerieModel.fromEntity(serie);

      final currentfavorites = await _storage.get(key: key);
      currentfavorites.add(model.toMap());

      await _storage.set(key: key, value: currentfavorites);
      return right(unit);
    } on AppException catch (e) {
      return left(e.toFailure());
    }
  }
}
