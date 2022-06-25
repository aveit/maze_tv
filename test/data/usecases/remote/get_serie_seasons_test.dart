import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/serie_season_model.dart';
import 'package:maze_tv/data/usecases/remote/get_serie_seasons.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_serie_seasons.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetSerieSeasons sut;
  late ApiClientMock apiClientMock;
  final serie = TVSerie.empty(id: 59);

  setUp(() {
    apiClientMock = ApiClientMock();
    sut = GetSerieSeasonsRemote(apiClientMock);
  });

  test('Should call ApiClient with the correct values', () async {
    //? arrange
    when(
      () => apiClientMock.get(path: any(named: 'path')),
    ).thenAnswer((_) async => <SerieSeason>[]);

    //* act

    await sut(serie: serie);

    //! assert
    verify(
      () => apiClientMock.get(path: '/shows/${serie.id}/seasons'),
    );
  });

  group('FAILED', () {
    test('When http client throws, should return a left with a failure',
        () async {
      //? arrange
      when(() => apiClientMock.get(path: any(named: 'path'))).thenThrow(
        const ServerException(),
      );

      //* act
      final result = await sut.call(serie: serie);

      //! assert
      expect(result, const Left<Failure, dynamic>(ServerFailure()));
    });

    test('''
        When http client throws any Exception, should 
        return a left with UnexpectedFailure
        ''', () async {
      //? arrange
      when(() => apiClientMock.get(path: any(named: 'path'))).thenThrow(
        Exception(),
      );

      //* act
      final result = await sut.call(serie: serie);

      //! assert
      expect(result, const Left<Failure, dynamic>(UnexpectedFailure()));
    });
  });
  group('SUCCESS', () {
    test('When gets data, should return it converted to entities', () async {
      //? arrange
      final response = [
        {
          'id': 2,
          'url': 'https://www.tvmaze.com/seasons/2/under-the-dome-season-2',
          'number': 2,
          'name': '',
          'episodeOrder': 13,
          'premiereDate': '2014-06-30',
          'endDate': '2014-09-22',
          'network': {
            'id': 2,
            'name': 'CBS',
            'country': {
              'name': 'United States',
              'code': 'US',
              'timezone': 'America/New_York'
            },
            'officialSite': 'https://www.cbs.com/'
          },
          'webChannel': null,
          'image': {
            'medium':
                'https://static.tvmaze.com/uploads/images/medium_portrait/24/60942.jpg',
            'original':
                'https://static.tvmaze.com/uploads/images/original_untouched/24/60942.jpg'
          },
          'summary': '',
          '_links': {
            'self': {'href': 'https://api.tvmaze.com/seasons/2'}
          }
        },
        {
          'id': 6233,
          'url': 'https://www.tvmaze.com/seasons/6233/under-the-dome-season-3',
          'number': 3,
          'name': '',
          'episodeOrder': 13,
          'premiereDate': '2015-06-25',
          'endDate': '2015-09-10',
          'network': {
            'id': 2,
            'name': 'CBS',
            'country': {
              'name': 'United States',
              'code': 'US',
              'timezone': 'America/New_York'
            },
            'officialSite': 'https://www.cbs.com/'
          },
          'webChannel': null,
          'image': {
            'medium':
                'https://static.tvmaze.com/uploads/images/medium_portrait/182/457332.jpg',
            'original':
                'https://static.tvmaze.com/uploads/images/original_untouched/182/457332.jpg'
          },
          'summary': '',
          '_links': {
            'self': {'href': 'https://api.tvmaze.com/seasons/6233'}
          }
        }
      ];
      when(() => apiClientMock.get(path: any(named: 'path'))).thenAnswer(
        (_) async => response,
      );

      //* act
      final result = await sut(serie: serie);

      //! assert
      final deepEq = const DeepCollectionEquality().equals;
      final expectedList = [
        SerieSeasonModel.fromJson(response.first).toEntity(),
        SerieSeasonModel.fromJson(response.last).toEntity(),
      ];

      expect(result.isRight(), true);
      expect(deepEq(result.getOrElse(() => []), expectedList), true);
    });
  });
}
