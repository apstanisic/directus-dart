import 'package:directus/src/data_classes/directus_storage.dart';

import '_auth_fields.dart';
import '_auth_response.dart';

class AuthStorage {
  DirectusStorage storage;

  /// Key used for differentiating between multiple storages
  AuthFields fields;

  AuthStorage(this.storage, {String? key}) : fields = AuthFields(key);

  /// Store login data to cold storage, and set it in memory.
  ///
  /// This method is used after fetching new data from server,
  Future<void> storeLoginData(AuthResponse data) async {
    await storage.setItem(fields.accessToken, data.accessToken);
    await storage.setItem(fields.accessTokenTtlInMs, data.accessTokenTtlMs);
    await storage.setItem(
        fields.expiresAt, data.accessTokenExpiresAt.toString());
    await storage.setItem(fields.refreshToken, data.refreshToken);
  }

  /// Store login data to both cold storage and in memory.
  ///
  /// This method should only be called in [init], this will fetch data
  /// from cold storage and return it.
  Future<AuthResponse?> getLoginData() async {
    final accessToken = await storage.getItem(fields.accessToken);
    final accessTokenMsValid = await storage.getItem(fields.accessTokenTtlInMs);
    final expiresAtString = await storage.getItem(fields.expiresAt);
    final refreshToken = await storage.getItem(fields.refreshToken);

    if (accessToken == null ||
        expiresAtString == null ||
        accessTokenMsValid == null ||
        refreshToken == null) {
      return null;
    }

    final loginData = AuthResponse(
      accessToken: accessToken,
      accessTokenExpiresAt: DateTime.parse(expiresAtString),
      accessTokenTtlMs: accessTokenMsValid,
      refreshToken: refreshToken,
    );

    return loginData;
  }
}
