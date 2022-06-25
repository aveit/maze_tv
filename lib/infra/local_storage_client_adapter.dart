import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:maze_tv/data/errors/exceptions.dart';

import 'package:maze_tv/data/local_storage/local_storage_client.dart';

class LocalStorageAdapter implements LocalStorageClient {
  const LocalStorageAdapter(this._storage);
  final LocalStorage _storage;

  @override
  Future<dynamic> get({required String key}) async {
    try {
      return await _storage.getItem(key);
    } catch (_) {
      throw const LocalException();
    }
  }

  @override
  Future<void> set({required String key, required dynamic value}) async {
    try {
      await _storage.setItem(key, value);
    } catch (_) {
      throw const LocalException();
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _storage.deleteItem(key);
    } catch (_) {
      throw const LocalException();
    }
  }
}
