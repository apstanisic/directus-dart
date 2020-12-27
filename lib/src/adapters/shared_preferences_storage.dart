import 'package:directus/src/data_classes/directus_error.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Use shared preferences as storage engine
class SharedPreferencesStorage extends DirectusStorage {
  late SharedPreferences? instance;

  SharedPreferencesStorage([SharedPreferences? instance]) : instance = instance;

  @override
  Future getItem(String key) async {
    final instance = this.instance ?? await SharedPreferences.getInstance();
    return instance.get(key);
  }

  @override
  Future<void> setItem(String key, value) async {
    final instance = this.instance ?? await SharedPreferences.getInstance();

    if (value is String) {
      await instance.setString(key, value);
    } else if (value is bool) {
      await instance.setBool(key, value);
    } else if (value is int) {
      await instance.setInt(key, value);
    } else if (value is double) {
      await instance.setDouble(key, value);
    } else {
      throw DirectusError(
        message: 'You can only store strings, numbers and booleans.',
        code: 1000,
        codeMessage: 'You can only store strings, numbers and booleans.',
      );
    }
  }
}
