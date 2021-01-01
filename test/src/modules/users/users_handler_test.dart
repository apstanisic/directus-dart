// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/handlers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  group('UsersHandler', () {
    late UsersHandler users;
    late Dio client;

    setUp(() {
      client = MockDio();
      users = UsersHandler(client: client);
    });

    test('that UsersHandler extends  ItemsHandler.', () async {
      final users = UsersHandler(client: MockDio());

      expect(users, isA<ItemsHandler>());
    });

    test('that `invite` works.', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await users.invite(email: 'test@email.com', roleId: 'some-uuid');

      verify(client.post(
        '/users/invite',
        data: {'email': 'test@email.com', 'role': 'some-uuid'},
      )).called(1);
    });

    test('that `inviteMany` works.', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await users.inviteMany(emails: ['test@example.com', 'test2@example.com'], role: 'some-uuid');

      verify(client.post('/users/invite', data: {
        'email': ['test@example.com', 'test2@example.com'],
        'role': 'some-uuid'
      })).called(1);
    });

    test('that `acceptInvite` works.', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response());

      await users.acceptInvite(password: 'some-password', token: 'some-token');

      verify(client.post(
        '/users/invite/accept',
        data: {'password': 'some-password', 'token': 'some-token'},
      )).called(1);
    });
  });
}
