/// Directus SDK that provides all needed APIs for using Directus server
///
/// It provides api for reading, creating, updating and deleting user and system data,
/// authentication, and access to activity.
///
/// ```dart
/// final sdk = await Directus('http://localhost:8055', storagePath: 'storage').init();
/// ```
library directus;

import 'package:dio/dio.dart';
import 'package:directus/src/directus_sdk.dart';

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
}
