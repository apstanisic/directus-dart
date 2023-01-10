import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/auth/_auth_response.dart';
import 'package:test/test.dart';

void main() {
  group('AuthResponse', () {
    late Map<String, Map<String, dynamic>> validResponse;

    setUp(
      () {
        validResponse = {
          'data': {
            'access_token': 'at',
            'refresh_token': 'rt',
            'expires': 5000,
          }
        };
      },
    );

    test('Constructor', () {
      final response = AuthResponse(
        accessToken: 'ac',
        accessTokenExpiresAt: DateTime.now(),
        accessTokenTtlMs: 5000,
        refreshToken: 'rt',
      );

      expect(response, isA<AuthResponse>());
    });

    test('fromRequest', () async {
      final httpResponse = Response(
        requestOptions: RequestOptions(path: '/'),
        data: validResponse,
      );
      final now = DateTime.now();
      final response = AuthResponse.fromResponse(httpResponse);

      expect(response.accessToken, 'at');
      expect(response.refreshToken, 'rt');
      expect(response.accessTokenTtlMs, 5000);
      expect(response.accessTokenExpiresAt, isA<DateTime>());

      expect(
        now
            .add(Duration(milliseconds: 5000))
            .isBefore(response.accessTokenExpiresAt),
        isTrue,
      );

      expect(
        now
            .add(Duration(milliseconds: 5000, seconds: 1))
            .isAfter(response.accessTokenExpiresAt),
        isTrue,
      );
    });

    test('Throws if response data is null', () {
      expect(
        () => AuthResponse.fromResponse(
            Response(requestOptions: RequestOptions(path: '/'))),
        throwsException,
      );
    });

    test('Throws if access token does not exist', () {
      validResponse['data']?.remove('access_token');
      expect(
        () => AuthResponse.fromResponse(Response(
            data: validResponse, requestOptions: RequestOptions(path: '/'))),
        throwsException,
      );
    });

    test('Throws if expires does not exist', () {
      validResponse['data']?.remove('expires');
      expect(
          () => AuthResponse.fromResponse(Response(
                data: validResponse,
                requestOptions: RequestOptions(path: '/'),
              )),
          throwsException);
    });

    test('Throws if refresh token does not exist', () {
      validResponse['data']?.remove('refresh_token');
      expect(
          () => AuthResponse.fromResponse(Response(
                data: validResponse,
                requestOptions: RequestOptions(path: '/'),
              )),
          throwsException);
    });
  });
}
