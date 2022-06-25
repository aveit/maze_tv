import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/data/local_storage/local_storage_client.dart';
import 'package:mocktail/mocktail.dart';

class ApiClientMock extends Mock implements ApiClient {}

class ClientMock extends Mock implements Client {}

class LocalStorageMock extends Mock implements LocalStorage {}

class LocalStorageClientMock extends Mock implements LocalStorageClient {}
