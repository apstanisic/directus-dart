import 'package:dio/dio.dart';
import 'package:directus/src/handlers/auth/_tfa.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  group('Tfa', () {
    late Dio client;
    late Tfa tfa;

    setUp(() {
      client = MockDio();
      tfa = Tfa(client: client);
    });
    test('enable', () async {
      when(client.post('/users/tfa/enable', data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await tfa.enable('some-password');

      verify(client.post('/users/tfa/enable', data: {'password': 'some-password'})).called(1);
    });

    test('disable', () async {
      when(client.post('/users/tfa/disable', data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());
      await tfa.disable('some-otp');

      verify(client.post('/users/tfa/disable', data: {'otp': 'some-otp'})).called(1);
    });
  });
}
