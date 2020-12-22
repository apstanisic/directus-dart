import 'package:hive/hive.dart';

abstract class DirectusStore {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
}

abstract class DirectusStorage {
  Future<void> setItem(String key, dynamic value);
  Future<dynamic?> getItem(String key);
}
