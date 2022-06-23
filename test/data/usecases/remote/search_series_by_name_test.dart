import 'package:maze_tv/data/usecases/remote/search_series_by_name.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/usecases/search_series_by_name.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';

void main() {
  late SearchSeriesByName sut;
  late ApiClientMock apiClientMock;

  setUp(() {
    apiClientMock = ApiClientMock();
    sut = SearchSeriesByNameRemote(apiClientMock);
  });

  test('Should call ApiClient with the correct values', () async {
    //? arrange
    const serieName = 'something';
    when(
      () => apiClientMock.get(
        path: any(named: 'path'),
        queryParams: any(named: 'queryParams'),
      ),
    ).thenAnswer((_) async => <TVSerie>[]);

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
}
