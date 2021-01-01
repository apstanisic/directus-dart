import 'package:directus/src/data_classes/directus_storage.dart';

import '_auth_response.dart';

/// Field names that are used to store data
class _Fields {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const accessTokenTtlInSeconds = 'access_token_ttl_in_seconds';
  static const expiresAt = 'access_token_expires_at';
}

class AuthStorage {
  DirectusStorage storage;

  AuthStorage(this.storage);

  /// Store login data to cold storage, and set it in memory.
  ///
  /// This method is used after fetching new data from server,
  Future<void> storeLoginData(AuthResponse data) async {
    await storage.setItem(_Fields.accessToken, data.accessToken);
    await storage.setItem(_Fields.accessTokenTtlInSeconds, data.accessTokenTtlInSeconds);
    await storage.setItem(_Fields.expiresAt, data.accessTokenExpiresAt.toString());
    await storage.setItem(_Fields.refreshToken, data.refreshToken);
  }

  /// Store login data to both cold storage and in memory.
  ///
  /// This method should only be called in [init], this will fetch data
  /// from cold storage and return it.
  Future<AuthResponse?> getLoginData() async {
    final accessToken = await storage.getItem(_Fields.accessToken);
    final accessTokenMsValid = await storage.getItem(_Fields.accessTokenTtlInSeconds);
    final expiresAtString = await storage.getItem(_Fields.expiresAt);
    final refreshToken = await storage.getItem(_Fields.refreshToken);

    if (accessToken == null ||
        expiresAtString == null ||
        accessTokenMsValid == null ||
        refreshToken == null) {
      return null;
    }

    final loginData = AuthResponse(
      accessToken: accessToken,
      accessTokenExpiresAt: DateTime.parse(expiresAtString),
      accessTokenTtlInSeconds: accessTokenMsValid,
      refreshToken: refreshToken,
    );

    return loginData;
  }
}
