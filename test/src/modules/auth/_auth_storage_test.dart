import 'package:directus/src/modules/auth/_auth_fields.dart';
import 'package:directus/src/modules/auth/_auth_response.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

// import '../../mock/mock_directus_storage.dart';

void main() {
  group('AuthStorage', () {
    late MockDirectusStorage storage;
    late AuthStorage authStorage;
    late AuthFields fields;

    setUp(() {
      storage = MockDirectusStorage();
      authStorage = AuthStorage(storage);
      fields = AuthFields();
    });
    test('storeLoginData', () async {
      final now = DateTime.now();
      when(storage.setItem(any, any)).thenAnswer((realInvocation) async {});
      await authStorage.storeLoginData(
        AuthResponse(
          accessToken: 'accessToken',
          accessTokenExpiresAt: now,
          accessTokenTtlMs: 1000,
          refreshToken: 'refreshToken',
        ),
      );

      verify(storage.setItem(fields.accessToken, 'accessToken')).called(1);
      verify(storage.setItem(fields.refreshToken, 'refreshToken')).called(1);
      verify(storage.setItem(fields.accessTokenTtlInMs, 1000)).called(1);
      verify(storage.setItem(fields.expiresAt, now.toString())).called(1);
    });

    test('getLoginData', () async {
      when(storage.getItem(fields.accessToken))
          .thenAnswer((realInvocation) async => 'at');
      when(storage.getItem(fields.refreshToken))
          .thenAnswer((realInvocation) async => 'rt');
      when(storage.getItem(fields.expiresAt))
          .thenAnswer((realInvocation) async => DateTime.now().toString());
      when(storage.getItem(fields.accessTokenTtlInMs))
          .thenAnswer((realInvocation) async => 1000);

      final data = await authStorage.getLoginData();

      expect(data, isA<AuthResponse>());
      expect(data?.accessToken, 'at');
      expect(data?.refreshToken, 'rt');
      expect(data?.accessTokenTtlMs, 1000);
      expect(data?.accessTokenExpiresAt, isA<DateTime>());
      verify(storage.getItem(any)).called(4);
    });
  });
}
