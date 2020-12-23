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
    // test('storeLoginData', () async {
    //   final now = DateTime.now();
    //   when(storage.setItem('', any)).thenAnswer((realInvocation) async {});
    //   await authStorage.storeLoginData(
    //     AuthResponse(
    //       accessToken: 'accessToken',
    //       accessTokenExpiresAt: now,
    //       accessTokenMsValid: 1000,
    //       refreshToken: 'refreshToken',
    //     ),
    //   );

    //   verify(storage.setItem(accessTokenDurationField, 'accessToken')).called(1);
    //   verify(storage.setItem(refreshTokenField, 'refreshToken')).called(1);
    //   verify(storage.setItem(accessTokenDurationField, 1000)).called(1);
    //   verify(storage.setItem(expiresAtField, now.millisecondsSinceEpoch)).called(1);
    // }, skip: true);

    // test('getLoginData', () async {
    //   when(storage.getItem(accessTokenDurationField)).thenAnswer((realInvocation) async => 'at');
    //   when(storage.getItem(refreshTokenField)).thenAnswer((realInvocation) async => 'rt');
    //   when(storage.getItem(expiresAtField))
    //       .thenAnswer((realInvocation) async => DateTime.now().millisecondsSinceEpoch);
    //   when(storage.getItem(accessTokenDurationField)).thenAnswer((realInvocation) async => 1000);

    //   final data = await authStorage.getLoginData();

    //   verify(storage.getItem(accessTokenDurationField)).called(1);
    //   verify(storage.getItem(refreshTokenField)).called(1);
    //   verify(storage.getItem(expiresAtField)).called(1);
    //   verify(storage.getItem(accessTokenDurationField)).called(1);
    // });
  });
}
