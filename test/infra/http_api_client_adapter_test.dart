import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:maze_tv/infra/http_api_client_adapter.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late HttpAdapter sut;
  late ClientMock clientMock;
  const url = 'mysite.com';

  setUp(() {
    clientMock = ClientMock();
    sut = HttpAdapter(basePath: url, httpClient: clientMock);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse('anyurl'));
  });

  When<dynamic> mockGetCall() => when(
        () => clientMock.get(
          any(),
          headers: any(
            named: 'headers',
          ),
        ),
      );
  void mockGet(
    int statusCode, {
    String body = '{"any_key":"any_value"}',
    Map<String, dynamic>? queryParams,
  }) =>
      mockGetCall().thenAnswer((_) async => Response(body, statusCode));

  group(
    '[GET]',
    () {
      test('Should call get on HttpClient with correct values', () async {
        //? arrange
        const urlToGet = '/shows';
        mockGet(200);

        //* act
        await sut.get(path: urlToGet);

        //! assert
        verify(
          () => clientMock.get(
            Uri.https(url, urlToGet),
            headers: {
              'content-type': 'application/json; charset=utf-8',
              'accept': 'application/json',
            },
          ),
        );
      });

      test('Should call get on HttpClient even if adding more headers',
          () async {
        //? arrange
        const urlToGet = '/shows';
        mockGet(200);

        //* act
        await sut.get(path: urlToGet, headers: {'added_header': 'added_value'});

        //! assert
        verify(
          () => clientMock.get(
            Uri.https(url, urlToGet),
            headers: {
              'content-type': 'application/json; charset=utf-8',
              'accept': 'application/json',
              'added_header': 'added_value',
            },
          ),
        );
      });

      test('Should return data if get returns 200', () async {
        mockGet(200);

        final response = await sut.get(path: 'any');

        expect(response, <String, dynamic>{'any_key': 'any_value'});
      });

      test('Should return data if get returns 200 with a list', () async {
        mockGet(
          200,
          body: '[{"any_key":"any_value"}, {"any_key2":"any_value2"}]',
        );

        final response = await sut.get(path: 'any');

        expect(response, [
          {'any_key': 'any_value'},
          {'any_key2': 'any_value2'},
        ]);
      });

      test('Should call correctly passing query params', () async {
        const query = {'q': 'any'};
        const urlToGet = 'shows';
        mockGet(200, queryParams: query);

        await sut.get(path: urlToGet, queryParams: query);

        verify(
          () => clientMock.get(
            Uri.https(url, urlToGet, query),
            headers: {
              'content-type': 'application/json; charset=utf-8',
              'accept': 'application/json',
            },
          ),
        );
      });
    },
  );
}
