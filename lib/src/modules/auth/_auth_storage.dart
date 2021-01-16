import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:meta/meta.dart';

import '_auth_response.dart';

/// Field names that are used to store data
@visibleForTesting
class AuthFields {
  static const accessToken = 'directus__access_token';
  static const refreshToken = 'directus__refresh_token';
  static const accessTokenTtlInMs = 'directus__access_token_ttl_ms';
  static const expiresAt = 'directus__access_token_expires_at';
}

class AuthStorage {
  DirectusStorage storage;

  AuthStorage(this.storage);

  /// Store login data to cold storage, and set it in memory.
  ///
  /// This method is used after fetching new data from server,
  Future<void> storeLoginData(AuthResponse data) async {
    await storage.setItem(AuthFields.accessToken, data.accessToken);
    await storage.setItem(AuthFields.accessTokenTtlInMs, data.accessTokenTtlMs);
    await storage.setItem(AuthFields.expiresAt, data.accessTokenExpiresAt.toString());
    await storage.setItem(AuthFields.refreshToken, data.refreshToken);
  }

  /// Store login data to both cold storage and in memory.
  ///
  /// This method should only be called in [init], this will fetch data
  /// from cold storage and return it.
  Future<AuthResponse?> getLoginData() async {
    final accessToken = await storage.getItem(AuthFields.accessToken);
    final accessTokenMsValid = await storage.getItem(AuthFields.accessTokenTtlInMs);
    final expiresAtString = await storage.getItem(AuthFields.expiresAt);
    final refreshToken = await storage.getItem(AuthFields.refreshToken);

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
