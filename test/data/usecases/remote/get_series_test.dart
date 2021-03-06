import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/data/usecases/remote/get_series.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_series.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetSeries sut;
  late ApiClientMock apiClientMock;

  setUp(() {
    apiClientMock = ApiClientMock();
    sut = GetTVSeriesImpl(
      apiClient: apiClientMock,
    );
  });

  When<dynamic> mockCall() {
    return when(
      () => apiClientMock.get(
        path: any(named: 'path'),
        queryParams: any(named: 'queryParams'),
      ),
    );
  }

  group(
    '[CORRECT VALUES]',
    () {
      test('When not passing a page, should call with page = 1', () async {
        //? arrange
        mockCall().thenAnswer((_) async => <TVSerie>[]);

        //* act
        await sut();

        //! assert
        verify(
          () => apiClientMock.get(path: '/shows', queryParams: {'page': '1'}),
        );
      });
      test('When passing a page number, should call with this number',
          () async {
        //? arrange
        mockCall().thenAnswer((_) async => <TVSerie>[]);
        const pgNumber = 10;

        //* act
        await sut(page: pgNumber);

        //! assert
        verify(
          () => apiClientMock.get(
            path: '/shows',
            queryParams: {'page': '$pgNumber'},
          ),
        );
      });
    },
  );

  group('FAILED', () {
    test('When http client throws, should return a left with a failure',
        () async {
      //? arrange
      mockCall().thenThrow(
        const ServerException(),
      );

      //* act
      final result = await sut.call();

      //! assert
      expect(result, const Left<Failure, dynamic>(ServerFailure()));
    });
  });
  group('SUCCESS', () {
    test('When gets data, should return it converted to entities', () async {
      //? arrange
      final response = [
        {
          'id': 1,
          'url': 'https://www.tvmaze.com/shows/1/under-the-dome',
          'name': 'Under the Dome',
          'type': 'Scripted',
          'language': 'English',
          'genres': ['Drama', 'Science-Fiction', 'Thriller'],
          'status': 'Ended',
          'runtime': 60,
          'averageRuntime': 60,
          'premiered': '2013-06-24',
          'ended': '2015-09-10',
          'officialSite': 'http://www.cbs.com/shows/under-the-dome/',
          'schedule': {
            'time': '22:00',
            'days': ['Thursday']
          },
          'rating': {'average': 6.5},
          'weight': 98,
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
          'dvdCountry': null,
          'externals': {
            'tvrage': 25988,
            'thetvdb': 264492,
            'imdb': 'tt1553656'
          },
          'image': {
            'medium':
                'https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg',
            'original':
                'https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg'
          },
          'summary':
              "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>",
          'updated': 1631010933,
          '_links': {
            'self': {'href': 'https://api.tvmaze.com/shows/1'},
            'previousepisode': {
              'href': 'https://api.tvmaze.com/episodes/185054'
            }
          }
        },
        {
          'id': 2,
          'url': 'https://www.tvmaze.com/shows/2/person-of-interest',
          'name': 'Person of Interest',
          'type': 'Scripted',
          'language': 'English',
          'genres': ['Action', 'Crime', 'Science-Fiction'],
          'status': 'Ended',
          'runtime': 60,
          'averageRuntime': 60,
          'premiered': '2011-09-22',
          'ended': '2016-06-21',
          'officialSite': 'http://www.cbs.com/shows/person_of_interest/',
          'schedule': {
            'time': '22:00',
            'days': ['Tuesday']
          },
          'rating': {'average': 8.8},
          'weight': 97,
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
          'dvdCountry': null,
          'externals': {
            'tvrage': 28376,
            'thetvdb': 248742,
            'imdb': 'tt1839578'
          },
          'image': {
            'medium':
                'https://static.tvmaze.com/uploads/images/medium_portrait/163/407679.jpg',
            'original':
                'https://static.tvmaze.com/uploads/images/original_untouched/163/407679.jpg'
          },
          'summary':
              "<p>You are being watched. The government has a secret system, a machine that spies on you every hour of every day. I know because I built it. I designed the Machine to detect acts of terror but it sees everything. Violent crimes involving ordinary people. People like you. Crimes the government considered \"irrelevant\". They wouldn't act so I decided I would. But I needed a partner. Someone with the skills to intervene. Hunted by the authorities, we work in secret. You'll never find us. But victim or perpetrator, if your number is up, we'll find you.</p>",
          'updated': 1631565378,
          '_links': {
            'self': {'href': 'https://api.tvmaze.com/shows/2'},
            'previousepisode': {
              'href': 'https://api.tvmaze.com/episodes/659372'
            }
          }
        }
      ];

      mockCall().thenAnswer((_) async => response);

      //* act
      final result = await sut();

      //! assert
      final deepEq = const DeepCollectionEquality().equals;
      final expectedList = [
        TvSerieModel.fromJson(response.first).toEntity(),
        TvSerieModel.fromJson(response.last).toEntity(),
      ];

      expect(result.isRight(), true);
      expect(deepEq(result.getOrElse(() => []), expectedList), true);
    });
  });
}
