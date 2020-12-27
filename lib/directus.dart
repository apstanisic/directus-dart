/// Directus SDK that provides all needed APIs for using Directus server
///
/// It provides APIs for reading, creating, updating and deleting user and system data,
/// authentication, and access to activity.
///
/// ```dart
/// final sdk = await Directus('http://localhost:8055').init();
/// ```
library directus;

// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/adapters/shared_preferences_storage.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:directus/src/directus_sdk.dart';

export 'src/data_classes/data_classes.dart';

class Directus {
  final DirectusSdk _sdk;
  Directus(String url, {DirectusStorage? storage, Dio? client})
      : _sdk = DirectusSdk(
          url,
          storage: storage ?? SharedPreferencesStorage(),
          client: client,
        );

  Future<DirectusSdk> init() async {
    await _sdk.init();
    return _sdk;
  }
}
