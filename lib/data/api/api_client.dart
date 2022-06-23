abstract class ApiClient {
  Future<dynamic> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  });
}
