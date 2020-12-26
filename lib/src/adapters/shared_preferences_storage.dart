import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Use shared preferences as storage engine
class SharedPreferencesStorage extends DirectusStorage {
  @override
  Future getItem(String key) async {
    final instance = await SharedPreferences.getInstance();
    return instance.get(key);
  }

  @override
  Future<void> setItem(String key, value) async {
    final instance = await SharedPreferences.getInstance();

    if (value is String) await instance.setString(key, value);
    if (value is bool) await instance.setBool(key, value);
    if (value is int) await instance.setInt(key, value);
    if (value is double) await instance.setDouble(key, value);

    throw Exception('You can only store strings, numbers and booleans.');
  }
}
