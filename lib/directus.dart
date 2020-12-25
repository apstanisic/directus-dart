/// Directus SDK that provides all needed APIs for using Directus server
///
/// It provides APIs for reading, creating, updating and deleting user and system data,
/// authentication, and access to activity.
///
/// ```dart
/// final sdk = await Directus('http://localhost:8055', storagePath: 'storage').init();
/// ```
library directus;

import 'package:dio/dio.dart';
import 'package:directus/src/directus_sdk.dart';
import 'package:directus/src/data_classes/directus_storage.dart';

export 'src/data_classes/data_classes.dart';

class Directus {
  final DirectusSdk _sdk;
  Directus(String url)
      : _sdk = DirectusSdk(
          url,
          // TODO Decide on storage
          storage: {} as dynamic,
        );

  Future<DirectusSdk> init() async {
    await _sdk.init();
    return _sdk;
  }

  static DirectusSdk custom(
    String url, {
    required DirectusStorage storage,
    required Dio client,
  }) {
    return DirectusSdk(url, storage: storage, client: client);
  }
}
