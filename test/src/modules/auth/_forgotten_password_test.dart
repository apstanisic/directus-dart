// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/auth/_forgotten_password.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  late Dio client;
  late ForgottenPassword fp;
  setUp(() {
    client = MockDio();
    fp = ForgottenPassword(client: client);
  });

  group('ForgottenPassword', () {
    test('requestPassword', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());
      await fp.request('email@test.com');
      verify(client.post('/auth/password/request', data: {'email': 'email@test.com'})).called(1);
    });

    test('requestPassword', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await fp.reset(token: 'token1', password: 'password1');

      verify(client.post('/auth/password/reset',
          data: {'token': 'token1', 'password': 'password1'})).called(1);
    });
  });
}
