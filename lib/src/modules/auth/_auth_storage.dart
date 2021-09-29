import 'package:directus/src/data_classes/directus_storage.dart';

import '_auth_fields.dart';
import '_auth_response.dart';

class AuthStorage {
  final DirectusStorage storage;

  /// Key used for differentiating between multiple storages
  final AuthFields fields;

  AuthStorage(
    this.storage, {
    String? key,
  }) : fields = AuthFields(key);

  /// Store login data to cold storage, and set it in memory.
  ///
  /// This method is used after fetching new data from server,
  Future<void> storeLoginData(AuthResponse data) async {
    await storage.setItem(fields.accessToken, data.accessToken);
    await storage.setItem(fields.accessTokenTtlInMs, data.accessTokenTtlMs);
    await storage.setItem(
        fields.expiresAt, data.accessTokenExpiresAt.toString());
    await storage.setItem(fields.refreshToken, data.refreshToken);

    return Future<void>.value();
  }

  /// Store login data to both cold storage and in memory.
  ///
  /// This method should only be called in [init], this will fetch data
  /// from cold storage and return it.
  Future<AuthResponse?> getLoginData() async {
    final accessToken = await storage.getItem(
      fields.accessToken,
    ) as String?;
    final expiresAtString = await storage.getItem(
      fields.expiresAt,
    ) as String?;
    final accessTokenMsValid = await storage.getItem(
      fields.accessTokenTtlInMs,
    ) as int?;
    final refreshToken = await storage.getItem(
      fields.refreshToken,
    ) as String?;

    if (accessToken == null ||
        expiresAtString == null ||
        accessTokenMsValid == null ||
        refreshToken == null) {
      return Future<AuthResponse?>.value(null);
    }

    final loginData = AuthResponse(
      accessToken: accessToken,
      accessTokenExpiresAt: DateTime.parse(expiresAtString),
      accessTokenTtlMs: accessTokenMsValid,
      refreshToken: refreshToken,
    );

    return Future<AuthResponse?>.value(loginData);
  }

  /// Delete data from storage
  ///
  /// This method should be called to deauthorize
  Future<void> removeLoginData() async {
    await storage.removeItem(fields.accessToken);
    await storage.removeItem(fields.accessTokenTtlInMs);
    await storage.removeItem(fields.expiresAt);
    await storage.removeItem(fields.refreshToken);

    return Future<void>.value();
  }
}
