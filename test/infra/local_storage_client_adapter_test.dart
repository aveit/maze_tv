import 'package:flutter_test/flutter_test.dart';
import 'package:maze_tv/data/errors/exceptions.dart';
import 'package:maze_tv/data/local_storage/local_storage_client.dart';
import 'package:maze_tv/data/models/tv_serie_model.dart';
import 'package:maze_tv/infra/local_storage_client_adapter.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late LocalStorageClient sut;
  late LocalStorageMock storage;

  setUp(() async {
    storage = LocalStorageMock();
    sut = LocalStorageAdapter(storage);
  });

  const myKey = 'favorites';
  const expectedMap = [
    {myKey: 'any_value'}
  ];
  const serieToSave = TvSerieModel(id: 1);

  When<dynamic> mockDeleteCall() => when(() => storage.deleteItem(any()));
  void mockDelete() => mockDeleteCall().thenAnswer((_) async => _);
  void mockDeleteError() => when(() => mockDeleteCall().thenThrow(Exception()));

  When<dynamic> mockSetCall() =>
      when(() => storage.setItem(any(), any<dynamic>()));
  void mockSet() => mockSetCall().thenAnswer((_) async => _);
  void mockSetError() => when(() => mockSetCall().thenThrow(Exception()));

  When<dynamic> mockGetCall() => when(() => storage.getItem(any()));
  void mockGet(dynamic data) => mockGetCall().thenAnswer((_) async => data);
  void mockGetError() => when(() => mockGetCall().thenThrow(Exception()));

  group('[SET]', () {
    test('Should call setItem on localStorage with correct values', () async {
      mockSet();
      await sut.set(key: myKey, value: serieToSave);

      verify(() => storage.setItem(myKey, serieToSave));
    });

    test('Should throw if localStorage throws', () async {
      mockSetError();

      final future = sut.set(key: myKey, value: 'any');

      expect(future, throwsA(const LocalException()));
    });
  });

  group('[DELETE]', () {
    test('Should call deleteItem on localStorage with correct values',
        () async {
      mockDelete();
      await sut.delete(key: myKey);

      verify(() => storage.deleteItem(myKey));
    });

    test('Should throw if deleteItem throws', () async {
      mockDeleteError();

      final future = sut.delete(key: myKey);

      expect(future, throwsA(const LocalException()));
    });
  });

  group(
    '[GET]',
    () {
      group('[SUCCESS]', () {
        test('''
          Should call get on LocalStorage with correct values
          ''', () async {
          //? arrange
          mockGet('[{"key":"data"},{"key2":"data2"}]');

          //* act
          await sut.get(key: myKey);

          //! assert
          verify(() => storage.getItem(myKey));
        });

        test('''
          Should return a List<Map<String, dynamic>> when has data
          ''', () async {
          //? arrange
          mockGet("[{\"$myKey\":\"any_value\"}]");

          //* act
          final result = await sut.get(key: myKey);

          //! assert
          expect(result, expectedMap);
        });
      });

      group('[ERROR]', () {
        test('''
          When SharedPreferences throw, should return a LocalException
          ''', () async {
          //? arrange
          mockGetError();

          //* act
          final call = sut.get;

          //! assert
          expect(
            () => call.call(key: myKey),
            throwsA(const LocalException()),
          );
        });
      });
    },
  );
}
