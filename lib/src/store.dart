import 'package:hive/hive.dart';

class HiveStore extends DirectusStore {
  Box storage;
  HiveStore(this.storage);

  @override
  Future<dynamic> getItem(String key) async {
    return await storage.get(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    await storage.put(key, value);
  }
}

abstract class DirectusStore {
  Future<dynamic> getItem(String key);
  Future<void> setItem(String key, String value);
}
