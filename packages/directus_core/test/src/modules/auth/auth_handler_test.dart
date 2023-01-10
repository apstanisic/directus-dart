import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';
import 'package:directus_core/src/modules/auth/_auth_response.dart';
import 'package:directus_core/src/modules/auth/_auth_storage.dart';
import 'package:directus_core/src/modules/auth/_current_user.dart';
import 'package:directus_core/src/modules/auth/_tfa.dart';
import 'package:directus_core/src/modules/auth/auth_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_auth_response.dart';
import '../../mock/mock_dio_response.dart';
import '../../mock/mocks.mocks.dart';

// class MockAuthStorage extends Mock implements AuthStorage {}

void main() {
  group('AuthHandler', () {
    late MockDirectusStorage storage;
    late MockDio client;
    late MockDio refreshClient;
    late AuthHandler auth;
    late MockAuthStorage authStorage;
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
      authStorage = MockAuthStorage();
      when(client.options).thenReturn(BaseOptions(baseUrl: '/'));
      when(client.interceptors).thenReturn(Interceptors());
      when(storage.getItem('directus__access_token'))
          .thenAnswer((realInvocation) async => 'test');

      when(refreshClient.options).thenReturn(BaseOptions(baseUrl: '/'));
      auth = AuthHandler(
          client: client, storage: storage, refreshClient: refreshClient);
      auth.storage = authStorage;
      when(authStorage.getLoginData())
          .thenAnswer((realInvocation) async => null);
      await auth.init();
    });

    test('logout', () async {
      when(client.post('auth/logout', data: anyNamed('data'))).thenAnswer(
          (realInvocation) async =>
              Response(requestOptions: RequestOptions(path: '/')));

      final loginData = mockAuthResponse();
      auth.tokens = loginData;
      await auth.logout();

      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
      verify(client.post('auth/logout',
          data: {'refresh_token': loginData.refreshToken})).called(1);
    });

    test('logout throws error if user is not logged in', () async {
      // reset(client);
      // verifyNoMoreInteractions(client);
      auth.tokens = null;
      expect(() => auth.logout(), throwsA(isA<DirectusError>()));
      verifyNever(client.post(any));
      verifyNever(client.delete(any));
      verifyNever(client.get(any));
      // verifyZeroInteractions(client);
    });

    test('init', () async {
      when(storage.getItem(any)).thenAnswer((realInvocation) async => null);
      final auth = AuthHandler(
          client: client, storage: storage, refreshClient: refreshClient);
      await auth.init();
      expect(auth.tokens, isNull);
      expect(auth.currentUser, isNull);
      expect(auth.tfa, isNull);
    });

    test('Init properties when user is logged in', () async {
      when(authStorage.getLoginData())
          .thenAnswer((realInvocation) async => mockAuthResponse());

      final auth = AuthHandler(
          client: client, storage: storage, refreshClient: refreshClient);
      auth.storage = authStorage;
      await auth.init();

      expect(auth.tokens, isA<AuthResponse>());
      expect(auth.currentUser, isA<CurrentUser>());
      expect(auth.tfa, isA<Tfa>());
    });

    test('isLoggedIn', () {
      expect(auth.isLoggedIn, false);
      auth.tokens = mockAuthResponse();
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

      auth.storage = AuthStorage(storage);
      await auth.login(
          email: 'email@email', password: 'password1', otp: 'otp1');

      expect(auth.tokens, isA<AuthResponse>());
      expect(auth.currentUser, isA<CurrentUser>());
      expect(auth.tfa, isA<Tfa>());

      verify(storage.setItem(any, any)).called(4);

      verify(client.post('auth/login', data: {
        'mode': 'json',
        'email': 'email@email',
        'password': 'password1',
        'otp': 'otp1',
      })).called(1);
    });

    test('Do not get new access token if user is not logged in.', () async {
      reset(refreshClient);
      auth.tokens = null;
      final interceptorHandler = MockRequestInterceptorHandler();
      await auth.refreshExpiredTokenInterceptor(
        RequestOptions(path: '/'),
        interceptorHandler,
      );

      verifyZeroInteractions(refreshClient);
      verify(interceptorHandler.next(any)).called(1);

      //
    });

    test('Do not get new access token if AT is valid for more then 10 seconds.',
        () async {
      reset(refreshClient);

      final interceptorHandler = MockRequestInterceptorHandler();
      auth.tokens = mockAuthResponse();
      auth.tokens?.accessTokenExpiresAt =
          DateTime.now().add(Duration(seconds: 11));
      await auth.refreshExpiredTokenInterceptor(
        RequestOptions(path: '/'),
        interceptorHandler,
      );

      verifyZeroInteractions(refreshClient);
      verify(interceptorHandler.next(any)).called(1);
      //
    });

    test('Get new access token if AT is valid for less then 10 seconds.',
        () async {
      when(refreshClient.post(any, data: anyNamed('data')))
          .thenAnswer(dioResponse({
        'data': {
          'refresh_token': 'rt',
          'access_token': 'at',
          'expires': 3600000,
        }
      }));
      auth.storage = authStorage;
      final loginData = mockAuthResponse();
      auth.tokens = loginData;
      auth.tokens!.accessTokenExpiresAt =
          DateTime.now().add(Duration(seconds: 9));
      final interceptorHandler = MockRequestInterceptorHandler();
      await auth.refreshExpiredTokenInterceptor(
        RequestOptions(path: '/'),
        interceptorHandler,
      );

      verify(interceptorHandler.next(any)).called(1);
      verify(refreshClient.post('auth/refresh', data: {
        'mode': 'json',
        'refresh_token': loginData.refreshToken,
      })).called(1);

      verify(authStorage.storeLoginData(any)).called(1);
    });

    test('init listener', () async {
      final auth = AuthHandler(
          client: client, storage: storage, refreshClient: refreshClient);
      auth.storage = authStorage;
      final authData = mockAuthResponse();
      when(authStorage.getLoginData()).thenAnswer((_) async => authData);
      auth.onChange((type, data) {
        expect(type, 'init');
        expect(data, authData);
      });
      await auth.init();
    });

    test('logout listener works', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      var called = 0;
      auth.onChange((type, data) {
        expect(called, 0);
        expect(type, 'logout');
        expect(data, null);
        called += 1;
      });

      auth.onChange((type, data) {
        expect(called, 1);
        called += 1;
      });

      auth.tokens = mockAuthResponse();
      await auth.logout();
      expect(called, 2);
    });

    test('login listener works', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer(dioResponse(getRefreshResponse()));

      var called = 0;

      auth.onChange((type, data) {
        expect(called, 0);
        expect(type, 'login');
        expect(data, isA<AuthResponse>());
        called += 1;
      });

      auth.onChange((type, data) {
        expect(called, 1);
        expect(type, 'login');
        expect(data, isA<AuthResponse>());
        called += 1;
      });

      await auth.login(
          email: 'email@email', password: 'password1', otp: 'otp1');
      expect(called, 2);
    });

    test('refreshing token listener works', () async {
      when(refreshClient.post(any, data: anyNamed('data')))
          .thenAnswer(dioResponse({
        'data': {
          'refresh_token': 'rt',
          'access_token': 'at',
          'expires': 10000,
        }
      }));
      var called = 0;
      auth.tokens = mockAuthResponse();
      auth.tokens!.accessTokenExpiresAt =
          DateTime.now().add(Duration(seconds: 4));
      auth.onChange((type, data) {
        expect(called, 0);
        expect(type, 'refresh');
        expect(data, isA<AuthResponse>());
        called += 1;
      });
      auth.onChange((type, data) {
        expect(called, 1);
        called += 1;
      });
      final interceptorHandler = MockRequestInterceptorHandler();

      await auth.refreshExpiredTokenInterceptor(
        RequestOptions(path: '/'),
        interceptorHandler,
      );
      expect(called, 2);
      verify(interceptorHandler.next(any)).called(1);
    });

    test('refreshing token rethrows DioError when manuallyRefresh failed',
        () async {
      final dioError = DioError(
          requestOptions: RequestOptions(path: '/'),
          response: Response(
            requestOptions: RequestOptions(path: '/'),
            data: 'error',
          ));
      final interceptorHandler = MockRequestInterceptorHandler();

      when(refreshClient.post(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) {
          throw dioError;
        },
      );

      // Setup for forcing refresh token
      auth.tokens = mockAuthResponse();
      auth.tokens!.accessTokenExpiresAt =
          DateTime.now().add(Duration(seconds: 4));

      await auth.refreshExpiredTokenInterceptor(
        RequestOptions(path: '/'),
        interceptorHandler,
      );

      // Check for the same dioError is thrown
      verify(interceptorHandler.reject(dioError)).called(1);
    });

    test('client is unlocked if refresh throws an error', () async {
      when(refreshClient.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) {
        throw DioError(
            requestOptions: RequestOptions(path: '/'),
            response: Response(
              requestOptions: RequestOptions(path: '/'),
              data: 'error',
            ));
      });
      auth.tokens = mockAuthResponse();

      try {
        await auth.manuallyRefresh();
      } catch (e) {
        expect(e, isA<DirectusError>());
      }

      verify(client.unlock()).called(1);
    });
  });
}
