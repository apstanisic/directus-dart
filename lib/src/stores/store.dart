import 'package:hive/hive.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import 'directus_store.dart';

class HiveStore {
  Box storage;
  HiveStore(this.storage);

  @override
  Future<String?> getItem(String key) async {
    return await storage.get(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    await storage.put(key, value);
  }
}

class SembastStorage extends DirectusStore {
  late Database storage;
  late StoreRef store;
  String path;

  SembastStorage({required this.path});

  Future<void> init() async {
    storage = await databaseFactoryIo.openDatabase(join(path, 'directus.db'));
    store = StoreRef.main();
  }

  @override
  Future<String> getString(String key) {
    // ignore: unnecessary_null_comparison
    if (store == null || storage == null) throw Exception('Storage not initialized');
    return store.record(key).get(storage) as Future<String>;
  }

  @override
  Future<void> setString(String key, String value) async {
    // ignore: unnecessary_null_comparison
    if (store == null || storage == null) throw Exception('Storage not initialized');
    await store.record(key).put(storage, value);
  }
}
