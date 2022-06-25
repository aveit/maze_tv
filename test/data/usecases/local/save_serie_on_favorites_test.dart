import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/data/usecases/local/save_serie_on_favorites.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/save_serie_on_favorites.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late SaveSerieOnFavorites sut;
  late LocalStorageClientMock storageMock;

  final serie1 = TVSerie.empty(id: 1);
  final serieModel1 = TvSerieModel.fromEntity(serie1);
  final serieMap1 = serieModel1.toMap();

  final serie2 = TVSerie.empty(id: 2);
  final serieModel2 = TvSerieModel.fromEntity(serie2);
  final serieMap2 = serieModel2.toMap();

  setUp(() {
    storageMock = LocalStorageClientMock();
    sut = SaveSerieOnFavoritesLocal(storageMock);
  });

  void mockGet() {
    when(
      () => storageMock.get(
        key: any(named: 'key'),
      ),
    ).thenAnswer((_) async => [serieMap1]);
  }

  test('Should call LocalStorageClient with the correct values', () async {
    //? arrange
    mockGet();
    when(
      () => storageMock.set(
        key: any(named: 'key'),
        value: any<dynamic>(named: 'value'),
      ),
    ).thenAnswer((_) async => [serieMap1]);

    //* act
    await sut(serie2);

    //! assert
    verify(() => storageMock.get(key: 'favorites'));
    verify(
      () => storageMock.set(key: 'favorites', value: [serieMap1, serieMap2]),
    );
  });

  group('FAILED', () {
    test('When LocalStorageClient throws, should return a left with a failure',
        () async {
      //? arrange
      mockGet();
      when(
        () => storageMock.set(
          key: any(named: 'key'),
          value: any<dynamic>(named: 'value'),
        ),
      ).thenThrow(
        const LocalException(),
      );

      //* act
      final result = await sut(serie1);

      //! assert
      expect(result, const Left<Failure, dynamic>(LocalFailure()));
    });
  });
  group('SUCCESS', () {
    test('When set data is ok, should return right(unit)', () async {
      //? arrange
      mockGet();
      when(
        () => storageMock.set(
          key: any(named: 'key'),
          value: any<dynamic>(named: 'value'),
        ),
      ).thenAnswer((_) async => '');

      //* act
      final result = await sut(serie1);

      //! assert
      expect(result, const Right<dynamic, Unit>(unit));
    });
  });
}
