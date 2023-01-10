import 'package:directus_core/directus_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Use shared preferences as storage engine
class SharedPreferencesStorage extends DirectusStorage {
  final SharedPreferences? _instance;

  /// User can provide it's instance for testing
  SharedPreferencesStorage([SharedPreferences? instance])
      : _instance = instance {
    // Fix for https://github.com/apstanisic/directus-dart/issues/19
    WidgetsFlutterBinding.ensureInitialized();
  }

  /// Get item from storage
  @override
  Future<Object?> getItem(String key) async {
    final instance = _instance ?? await SharedPreferences.getInstance();
    return instance.get(key);
  }

  /// Set item to storage
  ///
  /// Value can be either [String], [bool], [int] or [double].
  /// For any other type, it will throw [DirectusError].
  @override
  Future<void> setItem(String key, Object value) async {
    final instance = _instance ?? await SharedPreferences.getInstance();

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
      );
    }
  }

  /// Remove item from storage
  @override
  Future<void> removeItem(String key) async {
    final instance = _instance ?? await SharedPreferences.getInstance();
    await instance.remove(key);
  }
}
