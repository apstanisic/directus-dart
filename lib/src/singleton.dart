import 'package:directus/directus.dart';

class DirectusSingleton {
  static Directus? _instance;

  /// Initialize singleton
  ///
  static Future<void> init(String url) async {
    if (_instance != null) return;
    final sdk = Directus(url, key: '_singleton');
    await sdk.init();
    _instance = sdk;
  }

  /// Get singleton instance
  ///
  /// Make sure to call `init` before accessing `instance`

  static Directus get instance {
    if (_instance == null) {
      throw DirectusError(message: 'You must call initialize first');
    }

    return _instance!;
  }
}
