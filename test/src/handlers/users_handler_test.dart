import 'package:dio/dio.dart';
import 'package:directus/src/handlers/handlers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  group('UsersHandler', () {
    late UsersHandler users;
    late Dio client;

    setUp(() {
      client = MockDio();
      users = UsersHandler(client: client);
    });

    test('PresetsHandler have all methods of ItemsHandler', () async {
      final presets = UsersHandler(client: MockDio());

      expect(presets, isA<ItemsHandler>());
    });
    test('invite', () async {
      when(client.post('/users/invite', data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await users.invite(email: 'test@email.com', roleId: 'some-uuid');

      verify(client.post(
        '/users/invite',
        data: {'email': 'test@email.com', 'role': 'some-uuid'},
      )).called(1);
    });

    test('inviteMany', () async {
      when(client.post('/users/invite', data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await users.inviteMany(
          emails: ['test@example.com', 'test2@example.com'], role: 'some-uuid');

      verify(client.post(
        '/users/invite',
        data: {
          'email': ['test@example.com', 'test2@example.com'],
          'role': 'some-uuid'
        },
      )).called(1);
    });

    test('invite', () async {
      when(client.post('/users/invite/accept', data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await users.acceptInvite(password: 'some-password', token: 'some-token');

      verify(client.post(
        '/users/invite/accept',
        data: {'password': 'some-password', 'token': 'some-token'},
      )).called(1);
    });
  });
}
