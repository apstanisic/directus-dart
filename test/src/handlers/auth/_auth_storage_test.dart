import 'package:directus/src/handlers/auth/_auth_response.dart';
import 'package:directus/src/handlers/auth/_auth_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_directus_storage.dart';

/// Field names that are used to store data
class _Fields {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const accessTokenTtlInSeconds = 'access_token_ttl_in_seconds';
  static const expiresAt = 'access_token_expires_at';
}

void main() {
  group('AuthStorage', () {
    late MockDirectusStorage storage;
    late AuthStorage authStorage;

    setUp(() {
      storage = MockDirectusStorage();
      authStorage = AuthStorage(storage);
    });
    test('storeLoginData', () async {
      final now = DateTime.now();
      when(storage.setItem(any as dynamic, any)).thenAnswer((realInvocation) async {});
      await authStorage.storeLoginData(
        AuthResponse(
          accessToken: 'accessToken',
          accessTokenExpiresAt: now,
          accessTokenTtlInSeconds: 1000,
          refreshToken: 'refreshToken',
        ),
      );

      verify(storage.setItem(_Fields.accessToken, 'accessToken')).called(1);
      verify(storage.setItem(_Fields.refreshToken, 'refreshToken')).called(1);
      verify(storage.setItem(_Fields.accessTokenTtlInSeconds, 1000)).called(1);
      verify(storage.setItem(_Fields.expiresAt, now.toString())).called(1);
    });

    test('getLoginData', () async {
      when(storage.getItem(_Fields.accessToken)).thenAnswer((realInvocation) async => 'at');
      when(storage.getItem(_Fields.refreshToken)).thenAnswer((realInvocation) async => 'rt');
      when(storage.getItem(_Fields.expiresAt))
          .thenAnswer((realInvocation) async => DateTime.now().toString());
      when(storage.getItem(_Fields.accessTokenTtlInSeconds))
          .thenAnswer((realInvocation) async => 1000);

      final data = await authStorage.getLoginData();

      expect(data, isA<AuthResponse>());
      expect(data?.accessToken, 'at');
      expect(data?.refreshToken, 'rt');
      expect(data?.accessTokenTtlInSeconds, 1000);
      expect(data?.accessTokenExpiresAt, isA<DateTime>());
      verify(storage.getItem(any as dynamic)).called(4);
    });
  });
}
