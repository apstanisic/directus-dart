import 'package:directus_core/directus_core.dart';

class DirectusCoreSingleton {
  static DirectusCore? _instance;

  /// Initialize singleton
  ///
  static Future<void> init(String url,
      {required DirectusStorage storage}) async {
    if (_instance != null) return;
    final sdk = DirectusCore(url, key: '_singleton', storage: storage);
    await sdk.init();
    _instance = sdk;
  }

  /// Get singleton instance
  ///
  /// Make sure to call `init` before accessing `instance`
  static DirectusCore get instance {
    if (_instance == null) {
      throw DirectusError(message: 'You must call initialize first');
    }

    return _instance!;
  }

  static remove() {
    _instance = null;
  }
}
