import 'package:directus/src/stores/directus_store.dart';

import '_auth_response.dart';

const accessTokenField = 'access_token';
const refreshTokenField = 'refresh_token';
const accessTokenDurationField = 'access_token_duration';
const expiresAtField = 'access_token_expires_at';

class AuthStorage {
  DirectusStorage storage;

  AuthStorage(this.storage);

  /// Store login data to cold storage, and set it in memory.
  ///
  /// This method is used after fetching new data from server,
  /// this will store data to both cold storage and memory.
  /// For checking if the user is logged in, use [loginData].
  Future<void> storeLoginData(AuthResponse data) async {
    await storage.setItem(accessTokenField, data.accessToken);
    await storage.setItem(accessTokenDurationField, data.accessTokenMsValid);
    await storage.setItem(expiresAtField, data.accessTokenExpiresAt.millisecondsSinceEpoch);
    await storage.setItem(refreshTokenField, data.refreshToken);
  }

  /// Store login data to both cold storage and in memory.
  ///
  /// This method should only be called in [init], this will fetch data
  /// from cold storage, and if exist set it as [loginData].
  Future<AuthResponse?> getLoginData() async {
    final accessToken = await storage.getItem(accessTokenField);
    final accessTokenMsValid = await storage.getItem(accessTokenDurationField);
    final expiresAt = await storage.getItem(expiresAtField);
    final refreshToken = await storage.getItem(refreshTokenField);

    if (accessToken == null ||
        expiresAt == null ||
        accessTokenMsValid == null ||
        refreshToken == null) {
      return null;
    }

    final loginData = AuthResponse(
      accessToken: accessToken,
      accessTokenExpiresAt: DateTime.fromMillisecondsSinceEpoch(expiresAt),
      accessTokenMsValid: accessTokenMsValid,
      refreshToken: refreshToken,
    );

    return loginData;
  }
}
