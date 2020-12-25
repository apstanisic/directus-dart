import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../data_classes/directus_storage.dart';

class HiveStore extends DirectusStorage {
  Box storage;
  HiveStore(this.storage);

  @override
  Future<dynamic?> getItem(String key) async {
    return await storage.get(key);
  }

  @override
  Future<void> setItem(String key, dynamic value) async {
    await storage.put(key, value);
  }
}

class SembastStorage extends DirectusStorage {
  late Database storage;
  late StoreRef store;
  String path;

  SembastStorage({required this.path});

  Future<SembastStorage> init() async {
    storage = await databaseFactoryIo.openDatabase(join(path, 'directus.db'));
    store = StoreRef.main();
    return this;
  }

  @override
  Future<String> getItem(String key) {
    // ignore: unnecessary_null_comparison
    if (store == null || storage == null)
      throw Exception('Storage not initialized');
    return store.record(key).get(storage) as Future<String>;
  }

  @override
  Future<void> setItem(String key, dynamic value) async {
    // ignore: unnecessary_null_comparison
    if (store == null || storage == null)
      throw Exception('Storage not initialized');
    await store.record(key).put(storage, value);
  }
}
