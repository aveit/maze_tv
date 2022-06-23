import 'dart:convert';

import 'package:http/http.dart';

import 'package:maze_tv/data/api/api_client.dart';
import 'package:maze_tv/data/errors/exceptions.dart';

class HttpAdapter implements ApiClient {
  HttpAdapter({
    required this.basePath,
    required this.httpClient,
  }) : _defaultHeaders = {
          'content-type': 'application/json; charset=utf-8',
          'accept': 'application/json',
        };

  final Map<String, String> _defaultHeaders;

  final String basePath;
  final Client httpClient;

  @override
  Future<dynamic> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    final response = await httpClient.get(
      Uri.https(basePath, path, queryParams),
      headers: _defaultHeaders..addAll(headers ?? {}),
    );
    return _handleHttpResponse(response);
  }

  dynamic _handleHttpResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.isEmpty) {
          return null;
        }
        return jsonDecode(response.body);

      default:
        throw const UnexpectedException();
    }
  }
}
