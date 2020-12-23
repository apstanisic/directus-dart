import 'package:directus/src/handlers/auth/_auth_response.dart';
import 'package:directus/src/handlers/auth/_auth_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_directus_storage.dart';

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
          accessTokenMsValid: 1000,
          refreshToken: 'refreshToken',
        ),
      );

      verify(storage.setItem(accessTokenField, 'accessToken')).called(1);
      verify(storage.setItem(refreshTokenField, 'refreshToken')).called(1);
      verify(storage.setItem(accessTokenDurationField, 1000)).called(1);
      verify(storage.setItem(expiresAtField, now.millisecondsSinceEpoch)).called(1);
    });

    test('getLoginData', () async {
      when(storage.getItem(accessTokenField)).thenAnswer((realInvocation) async => 'at');
      when(storage.getItem(refreshTokenField)).thenAnswer((realInvocation) async => 'rt');
      when(storage.getItem(expiresAtField)).thenAnswer((realInvocation) async => 100000);
      when(storage.getItem(accessTokenDurationField)).thenAnswer((realInvocation) async => 1000);

      final data = await authStorage.getLoginData();

      expect(data, isA<AuthResponse>());
      expect(data?.accessToken, 'at');
      expect(data?.refreshToken, 'rt');
      expect(data?.accessTokenMsValid, 1000);
      expect(data?.accessTokenExpiresAt, isA<DateTime>());
      verify(storage.getItem(any as dynamic)).called(4);
    });
  });
}
