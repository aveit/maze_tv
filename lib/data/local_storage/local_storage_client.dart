abstract class LocalStorageClient {
  Future<List<Map<String, dynamic>>> get({required String key});
  Future<void> set({required String key, required dynamic value});
  Future<void> delete({required String key});
}
