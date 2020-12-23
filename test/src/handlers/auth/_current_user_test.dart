import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/response.dart';
import 'package:directus/src/handlers/auth/_current_user.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  group('Tfa', () {
    late Dio client;
    late CurrentUser currentUser;

    setUp(() {
      client = MockDio();
      currentUser = CurrentUser(client: client);
    });
    test('enable', () async {
      when(client.get('/users/me')).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': {'id': 1}
        }),
      );

      final response = await currentUser.info();

      expect(response, isA<DirectusResponse>());
      expect(response.data, {'id': 1});
      verify(client.get('/users/me')).called(1);
    });

    test('disable', () async {
      when(client.patch('/users/me', data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': {'id': 1, 'name': 'Test'}
        }),
      );

      final response = await currentUser.update(data: {'name': 'Test'});

      expect(response, isA<DirectusResponse>());
      expect(response.data, {'id': 1, 'name': 'Test'});
      verify(client.patch('/users/me', data: {'name': 'Test'})).called(1);
    });
  });
}
