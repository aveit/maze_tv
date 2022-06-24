import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/data/usecases/remote/search_series_by_name.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/search_series_by_name.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late SearchSeriesByName sut;
  late ApiClientMock apiClientMock;

  setUp(() {
    apiClientMock = ApiClientMock();
    sut = SearchSeriesByNameRemote(apiClientMock);
  });

  void mockError([Exception? e]) {
    when(
      () => apiClientMock.get(
        path: any(named: 'path'),
        queryParams: any(named: 'queryParams'),
      ),
    ).thenThrow(
      e ?? const ServerException(),
    );
  }

  void mockSuccess([List<Map<String, dynamic>>? result]) {
    when(
      () => apiClientMock.get(
        path: any(named: 'path'),
        queryParams: any(named: 'queryParams'),
      ),
    ).thenAnswer((_) async => result ?? [{}]);
  }

  test('Should call ApiClient with the correct values', () async {
    //? arrange
    const serieName = 'something';

    //* act
    await sut(serieName: serieName);

    //! assert
    verify(
      () => apiClientMock.get(
        path: '/search/shows',
        queryParams: {'q': serieName},
      ),
    );
  });

  group('[FAIL]', () {
    test('When the query is empty, should return an InvalidParameterFailure',
        () async {
      //? arrange
      //* act
      final result = await sut(serieName: '');

      //! assert
      expect(result, const Left(InvalidParamFailure()));
    });

    test(
        'When http client throws ServerException, should return a left with a failure',
        () async {
      //? arrange
      mockError();

      //* act
      final result = await sut.call(serieName: 'anyname');

      //! assert
      expect(result, const Left(ServerFailure()));
    });

    test(
        'When http client throws any Exception, should return a left with UnexpectedFailure',
        () async {
      //? arrange
      mockError(Exception());

      //* act
      final result = await sut.call(serieName: 'anyname');

      //! assert
      expect(result, const Left(UnexpectedFailure()));
    });
  });

  group(
    '[SUCCESS]',
    () {
      test('When gets data, should return it converted to entities', () async {
        //? arrange
        final response = [
          {
            'score': 0.9095458,
            'show': {
              'id': 139,
              'url': 'https://www.tvmaze.com/shows/139/girls',
              'name': 'Girls',
              'type': 'Scripted',
              'language': 'English',
              'genres': ['Drama', 'Romance'],
              'status': 'Ended',
              'runtime': 30,
              'averageRuntime': 30,
              'premiered': '2012-04-15',
              'ended': '2017-04-16',
              'officialSite': 'http://www.hbo.com/girls',
              'schedule': {
                'time': '22:00',
                'days': ['Sunday']
              },
              'rating': {'average': 6.7},
              'weight': 97,
              'network': {
                'id': 8,
                'name': 'HBO',
                'country': {
                  'name': 'United States',
                  'code': 'US',
                  'timezone': 'America/New_York'
                },
                'officialSite': 'https://www.hbo.com/'
              },
              'webChannel': null,
              'dvdCountry': null,
              'externals': {
                'tvrage': 30124,
                'thetvdb': 220411,
                'imdb': 'tt1723816'
              },
              'image': {
                'medium':
                    'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
                'original':
                    'https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg'
              },
              'summary':
                  '<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>',
              'updated': 1611310521,
              '_links': {
                'self': {'href': 'https://api.tvmaze.com/shows/139'},
                'previousepisode': {
                  'href': 'https://api.tvmaze.com/episodes/1079686'
                }
              }
            }
          },
          {
            'score': 0.8855909,
            'show': {
              'id': 41734,
              'url': 'https://www.tvmaze.com/shows/41734/girls',
              'name': 'GIRLS',
              'type': 'Scripted',
              'language': 'Mongolian',
              'genres': ['Comedy'],
              'status': 'Ended',
              'runtime': 41,
              'averageRuntime': null,
              'premiered': null,
              'ended': null,
              'officialSite': null,
              'schedule': {
                'time': '',
                'days': ['Thursday']
              },
              'rating': {'average': null},
              'weight': 58,
              'network': {
                'id': 1672,
                'name': 'UBS',
                'country': {
                  'name': 'Mongolia',
                  'code': 'MN',
                  'timezone': 'Asia/Ulaanbaatar'
                },
                'officialSite': null
              },
              'webChannel': null,
              'dvdCountry': null,
              'externals': {
                'tvrage': null,
                'thetvdb': null,
                'imdb': 'tt8709752'
              },
              'image': {
                'medium':
                    'https://static.tvmaze.com/uploads/images/medium_portrait/191/478539.jpg',
                'original':
                    'https://static.tvmaze.com/uploads/images/original_untouched/191/478539.jpg'
              },
              'summary': null,
              'updated': 1632080861,
              '_links': {
                'self': {'href': 'https://api.tvmaze.com/shows/41734'}
              }
            }
          }
        ];

        mockSuccess(response);

        //* act
        final result = await sut(serieName: 'serie');

        //! assert
        final deepEq = const DeepCollectionEquality().equals;
        final expectedList = [
          TvSerieModel.fromJson(response.first['show'] as Map<String, dynamic>)
              .toEntity(),
          TvSerieModel.fromJson(response.last['show'] as Map<String, dynamic>)
              .toEntity(),
        ];

        expect(result.isRight(), true);
        expect(deepEq(result.getOrElse(() => []), expectedList), true);
      });
    },
  );
}
