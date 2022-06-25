import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/models/episode_model.dart';
import 'package:maze_tv/data/usecases/remote/get_season_episodes.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_season_episodes.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetSeasonEpisodes sut;
  late ApiClientMock apiClientMock;
  final season = SerieSeason.empty(id: 59);

  setUp(() {
    apiClientMock = ApiClientMock();
    sut = GetSeasonsEpisodesRemote(apiClientMock);
  });

  test('Should call ApiClient with the correct values', () async {
    //? arrange
    when(
      () => apiClientMock.get(path: any(named: 'path')),
    ).thenAnswer((_) async => <SerieSeason>[]);

    //* act

    await sut(season: season);

    //! assert
    verify(
      () => apiClientMock.get(path: '/seasons/${season.id}/episodes'),
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
      final result = await sut.call(season: season);

      //! assert
      expect(result, const Left(ServerFailure()));
    });

    test(
        'When http client throws any Exception, should return a left with UnexpectedFailure',
        () async {
      //? arrange
      when(() => apiClientMock.get(path: any(named: 'path'))).thenThrow(
        Exception(),
      );

      //* act
      final result = await sut.call(season: season);

      //! assert
      expect(result, const Left(UnexpectedFailure()));
    });
  });
  group('SUCCESS', () {
    test('When gets data, should return it converted to entities', () async {
      //? arrange
      final response = [
        {
          'id': 142270,
          'url':
              'https://www.tvmaze.com/episodes/142270/under-the-dome-3x01-move-on',
          'name': 'Move On',
          'season': 3,
          'number': 1,
          'type': 'regular',
          'airdate': '2015-06-25',
          'airtime': '21:00',
          'airstamp': '2015-06-26T01:00:00+00:00',
          'runtime': 60,
          'rating': {'average': 8.3},
          'image': {
            'medium':
                'https://static.tvmaze.com/uploads/images/medium_landscape/12/31233.jpg',
            'original':
                'https://static.tvmaze.com/uploads/images/original_untouched/12/31233.jpg'
          },
          'summary':
              '<p>Season 3 begins with Chester\'s Mill residents appearing inside and outside the Dome following an evacuation into the tunnels beneath the town. Meanwhile, the Dome begins to reveal its ultimate agenda; and surprising alliances form as new residents emerge.</p>',
          '_links': {
            'self': {'href': 'https://api.tvmaze.com/episodes/142270'}
          }
        },
        {
          'id': 151048,
          'url':
              'https://www.tvmaze.com/episodes/151048/under-the-dome-3x02-but-im-not',
          'name': 'But I\'m Not',
          'season': 3,
          'number': 2,
          'type': 'regular',
          'airdate': '2015-06-25',
          'airtime': '22:00',
          'airstamp': '2015-06-26T02:00:00+00:00',
          'runtime': 60,
          'rating': {'average': 8},
          'image': {
            'medium':
                'https://static.tvmaze.com/uploads/images/medium_landscape/12/31234.jpg',
            'original':
                'https://static.tvmaze.com/uploads/images/original_untouched/12/31234.jpg'
          },
          'summary':
              '<p>Chester\'s Mill residents appear inside and outside the Dome following an exit into the tunnels beneath the town. Meanwhile, the Dome begins to reveal its ultimate agenda; and surprising alliances form as new residents emerge.</p>',
          '_links': {
            'self': {'href': 'https://api.tvmaze.com/episodes/151048'}
          }
        },
      ];
      when(() => apiClientMock.get(path: any(named: 'path'))).thenAnswer(
        (_) async => response,
      );

      //* act
      final result = await sut(season: season);

      //! assert
      final deepEq = const DeepCollectionEquality().equals;
      final expectedList = [
        EpisodeModel.fromJson(response.first).toEntity(),
        EpisodeModel.fromJson(response.last).toEntity(),
      ];

      expect(result.isRight(), true);
      expect(deepEq(result.getOrElse(() => []), expectedList), true);
    });
  });
}
