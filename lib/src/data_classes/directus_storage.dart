import 'package:hive/hive.dart';

abstract class DirectusStorage {
  Future<void> setItem(String key, dynamic value);
  Future<dynamic?> getItem(String key);
}
