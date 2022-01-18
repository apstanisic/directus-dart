import 'package:directus/directus.dart';

class DirectusSingleton {
  static Directus? _instance;

  static Future<void> initialize(String url) async {
    final sdk = Directus(url, key: 'singleton');
    await sdk.init();
    _instance = sdk;
  }

  static Directus get instance {
    if (_instance == null) {
      throw DirectusError(message: 'You must call initialize first');
    }

    return _instance!;
  }
}
