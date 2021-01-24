// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';
import 'package:directus/src/modules/auth/_auth_response.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:directus/src/modules/auth/_current_user.dart';
import 'package:directus/src/modules/auth/_tfa.dart';
import 'package:directus/src/modules/auth/auth_handler.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_auth_response.dart';
import '../../mock/mock_dio.dart';
import '../../mock/mock_dio_response.dart';
import '../../mock/mock_directus_storage.dart';

class MockAuthStorage extends Mock implements AuthStorage {}

void main() {
  group('AuthHandler', () {
    late DirectusStorage storage;
    late Dio client;
    late Dio refreshClient;
    late AuthHandler auth;
    late AuthStorage authStorage;
    Map getRefreshResponse() => {
          'data': {
            'refresh_token': 'rt',
            'access_token': 'at',
            'expires': 10000,
          }
        };

    setUp(() async {
      storage = MockDirectusStorage();
      client = MockDio();
      refreshClient = MockDio();
      auth = AuthHandler(client: client, storage: storage, refreshClient: refreshClient);
      authStorage = MockAuthStorage();
      await auth.init();
    });

    test('logout', () async {
      when(client.post('auth/logout', data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      final loginData = getAuthRespone();
      auth.tokens = loginData;
      await auth.logout();

      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
      verify(client.post('auth/logout', data: {'refresh_token': loginData.refreshToken})).called(1);
    });

    test('logout throws error if user is not logged in', () async {
      auth.tokens = null;
      expect(() => auth.logout(), throwsA(isA<DirectusError>()));
      verifyZeroInteractions(client);
    });

    test('init', () async {
      when(storage.getItem(any as dynamic)).thenAnswer((realInvocation) async => null);
      final auth = AuthHandler(client: client, storage: storage, refreshClient: refreshClient);
      await auth.init();
      expect(auth.tokens, isNull);
      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
    });

    test('Init properties when user is logged in', () async {
      when(authStorage.getLoginData()).thenAnswer((realInvocation) async => getAuthRespone());

      final auth = AuthHandler(client: client, storage: storage, refreshClient: refreshClient);
      auth.storage = authStorage;
      await auth.init();

      expect(auth.tokens, isA<AuthResponse>());
      expect(auth.currentUser, isA<CurrentUser>());
      expect(auth.tfa, isA<Tfa>());
    });

    test('isLoggedIn', () {
      expect(auth.isLoggedIn, false);
      auth.tokens = getAuthRespone();
      expect(auth.isLoggedIn, true);
    });

    test('login', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': {
          'access_token': 'ac',
          'refresh_token': 'rt',
          'expires': 1000,
        }
      }));

      expect(auth.tokens, isNull);
      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);

      await auth.login(email: 'email@email', password: 'password1', otp: 'otp1');

      expect(auth.tokens, isA<AuthResponse>());
      expect(auth.currentUser, isA<CurrentUser>());
      expect(auth.tfa, isA<Tfa>());

      verify(storage.setItem(any as dynamic, any)).called(4);

      verify(client.post('auth/login', data: {
        'mode': 'json',
        'email': 'email@email',
        'password': 'password1',
        'otp': 'otp1',
      })).called(1);
    });

    test('Do not get new access token if user is not logged in.', () async {
      auth.tokens = null;
      await auth.refreshExpiredTokenInterceptor(RequestOptions());

      verifyZeroInteractions(refreshClient);
      //
    });

    test('Do not get new access token if AT is valid for more then 10 seconds.', () async {
      auth.tokens = getAuthRespone();
      auth.tokens?.accessTokenExpiresAt = DateTime.now().add(Duration(seconds: 11));
      await auth.refreshExpiredTokenInterceptor(RequestOptions());

      verifyZeroInteractions(refreshClient);
      //
    });

    test('Get new access token if AT is valid for less then 10 seconds.', () async {
      when(refreshClient.post(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': {
          'refresh_token': 'rt',
          'access_token': 'at',
          'expires': 3600000,
        }
      }));
      auth.storage = authStorage;
      final loginData = getAuthRespone();
      auth.tokens = loginData;
      auth.tokens!.accessTokenExpiresAt = DateTime.now().add(Duration(seconds: 9));
      await auth.refreshExpiredTokenInterceptor(RequestOptions());

      verify(refreshClient.post('auth/refresh', data: {
        'mode': 'json',
        'refresh_token': loginData.refreshToken,
      })).called(1);

      verify(authStorage.storeLoginData(any as dynamic)).called(1);
    });

    test('init listener', () async {
      final auth = AuthHandler(client: client, storage: storage, refreshClient: refreshClient);
      auth.storage = authStorage;
      final authData = getAuthRespone();
      when(authStorage.getLoginData()).thenAnswer((_) async => authData);
      auth.onChange = (type, data) async {
        expect(type, 'init');
        expect(data, authData);
      };
      await auth.init();
    });

    test('logout listener works', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      var called = 0;
      auth.onChange = (type, data) async {
        expect(called, 0);
        expect(type, 'logout');
        expect(data, null);
        called += 1;
      };

      auth.onChange = (type, data) async {
        expect(called, 1);
        called += 1;
      };

      auth.tokens = getAuthRespone();
      await auth.logout();
      expect(called, 2);
    });

    test('login listener works', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse(getRefreshResponse()));

      var called = 0;

      auth.onChange = (type, data) async {
        expect(called, 0);
        expect(type, 'login');
        expect(data, isA<AuthResponse>());
        called += 1;
      };

      auth.onChange = (type, data) async {
        expect(called, 1);
        expect(type, 'login');
        expect(data, isA<AuthResponse>());
        called += 1;
      };

      await auth.login(email: 'email@email', password: 'password1', otp: 'otp1');
      expect(called, 2);
    });

    test('refreshing token listener works', () async {
      when(refreshClient.post(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': {
          'refresh_token': 'rt',
          'access_token': 'at',
          'expires': 10000,
        }
      }));
      var called = 0;
      auth.tokens = getAuthRespone();
      auth.tokens!.accessTokenExpiresAt = DateTime.now().add(Duration(seconds: 4));
      auth.onChange = (type, data) async {
        expect(called, 0);
        expect(type, 'refresh');
        expect(data, isA<AuthResponse>());
        called += 1;
      };
      auth.onChange = (type, data) async {
        expect(called, 1);
        called += 1;
      };

      await auth.refreshExpiredTokenInterceptor(RequestOptions());
      expect(called, 2);
    });

    test('client is unlocked if refresh throws an error', () async {
      when(refreshClient.post(any, data: anyNamed('data'))).thenAnswer((realInvocation) {
        throw DioError(
            response: Response(
          data: 'error',
        ));
      });
      auth.tokens = getAuthRespone();

      try {
        await auth.manuallyRefresh();
      } catch (e) {
        expect(e, isA<DirectusError>());
      }

      verify(client.unlock()).called(1);
    });
  });
}
