import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:dartz/dartz.dart';
import 'package:maze_tv/domain/usecases/save_serie_on_favorites.dart';

class SaveSerieOnFavoritesLocal implements SaveSerieOnFavorites {
  @override
  Future<Either<Failure, Unit>> call(TVSerie serie) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
