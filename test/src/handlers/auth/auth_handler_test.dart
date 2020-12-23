import 'package:dio/dio.dart';
import 'package:directus/src/handlers/auth/_auth_response.dart';
import 'package:directus/src/handlers/auth/_current_user.dart';
import 'package:directus/src/handlers/auth/_tfa.dart';
import 'package:directus/src/handlers/auth/auth_handler.dart';
import 'package:directus/src/stores/directus_store.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_auth_response.dart';
import '../../mock/mock_dio.dart';
import '../../mock/mock_directus_storage.dart';

void main() {
  group('AuthHandler', () {
    late DirectusStorage storage;
    late Dio client;
    late AuthHandler auth;
    setUp(() {
      storage = MockDirectusStorage();
      client = MockDio();
      auth = AuthHandler(client: client, storage: storage);
    });

    test('logout', () async {
      when(client.post('/auth/logout')).thenAnswer((realInvocation) async => Response());

      auth.loginData = getAuthRespones();

      await auth.logout();

      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
      verify(client.post('/auth/logout')).called(1);
    });

    test('isLoggedIn', () {
      expect(auth.isLoggedIn, false);
      auth.loginData = getAuthRespones();
      expect(auth.isLoggedIn, true);
    });

    test('requestPassword', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());
      await auth.requestPassword('email@test.com');
      verify(client.post('/auth/password/request', data: {'email': 'email@test.com'})).called(1);
    });

    test('requestPassword', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await auth.resetPassword(token: 'token1', password: 'password1');

      verify(client.post('/auth/password/reset',
          data: {'token': 'token1', 'password': 'password1'})).called(1);
    });

    test('login', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': {
            'access_token': 'ac',
            'refresh_token': 'rt',
            'expires': 1000,
          }
        }),
      );

      expect(auth.loginData, isNull);
      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);

      await auth.login(email: 'email@email', password: 'password1', otp: 'otp1');

      expect(auth.loginData, isA<AuthResponse>());
      expect(auth.currentUser, isA<CurrentUser>());
      expect(auth.tfa, isA<Tfa>());

      verify(storage.setItem(any as dynamic, any)).called(4);

      verify(client.post('/auth/login', data: {
        'mode': 'json',
        'email': 'email@email',
        'password': 'password1',
        'otp': 'otp1',
      })).called(1);
    });
  });
}
