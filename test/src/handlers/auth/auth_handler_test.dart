import 'package:dio/dio.dart';
import 'package:directus/src/handlers/auth/_auth_response.dart';
import 'package:directus/src/handlers/auth/_auth_storage.dart';
import 'package:directus/src/handlers/auth/_current_user.dart';
import 'package:directus/src/handlers/auth/_tfa.dart';
import 'package:directus/src/handlers/auth/auth_handler.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_auth_response.dart';
import '../../mock/mock_dio.dart';
import '../../mock/mock_directus_storage.dart';

class MockAuthStorage extends Mock implements AuthStorage {}

void main() {
  group('AuthHandler', () {
    late DirectusStorage storage;
    late Dio client;
    late Dio tokenClient;
    late AuthHandler auth;
    late AuthStorage authStorage;
    setUp(() async {
      storage = MockDirectusStorage();
      client = MockDio();
      tokenClient = MockDio();
      auth = AuthHandler(client: client, storage: storage, tokenClient: tokenClient);
      authStorage = MockAuthStorage();
      await auth.init();
    });

    test('logout', () async {
      when(client.post('/auth/logout')).thenAnswer((realInvocation) async => Response());

      auth.loginData = getAuthRespones();

      await auth.logout();

      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
      verify(client.post('/auth/logout')).called(1);
    });

    test('init', () async {
      when(storage.getItem(any as dynamic)).thenAnswer((realInvocation) => null);
      final auth = AuthHandler(client: client, storage: storage);
      await auth.init();
      expect(auth.loginData, isNull);
      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
    });

    test('Init properties when user is logged in', () async {
      when(authStorage.getLoginData()).thenAnswer((realInvocation) async => getAuthRespones());

      final auth = AuthHandler(client: client, storage: storage);
      auth.storage = authStorage;
      await auth.init();

      expect(auth.loginData, isA<AuthResponse>());
      expect(auth.currentUser, isA<CurrentUser>());
      expect(auth.tfa, isA<Tfa>());
    });

    test('isLoggedIn', () {
      expect(auth.isLoggedIn, false);
      auth.loginData = getAuthRespones();
      expect(auth.isLoggedIn, true);
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

    test('Do not get new access token if user is not logged in.', () async {
      auth.loginData = null;
      await auth.getNewTokenInInterceptor(RequestOptions());

      verifyZeroInteractions(tokenClient);
      //
    });

    test('Do not get new access token if AT is valid for more then 5 seconds.', () async {
      auth.loginData = getAuthRespones();
      auth.loginData?.accessTokenExpiresAt = DateTime.now().add(Duration(seconds: 10));
      await auth.getNewTokenInInterceptor(RequestOptions());

      verifyZeroInteractions(tokenClient);
      //
    });

    test('Get new access token if AT is valid for less then 5 seconds.', () async {
      when(tokenClient.post(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': {
            'refresh_token': 'rt',
            'access_token': 'at',
            'expires': 2000,
          }
        }),
      );
      auth.storage = authStorage;
      final loginData = getAuthRespones();
      auth.loginData = loginData;
      auth.loginData!.accessTokenExpiresAt = DateTime.now().add(Duration(seconds: 4));
      await auth.getNewTokenInInterceptor(RequestOptions());

      verify(tokenClient.post('/auth/refresh', data: {
        'mode': 'json',
        'refresh_token': loginData.refreshToken,
      })).called(1);

      verify(authStorage.storeLoginData(any as dynamic)).called(1);
    });
  });
}
