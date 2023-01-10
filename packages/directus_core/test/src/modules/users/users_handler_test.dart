import 'package:directus_core/src/modules/handlers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio_response.dart';
import '../../mock/mocks.mocks.dart';

void main() {
  group('UsersHandler', () {
    late UsersHandler users;
    late MockDio client;

    setUp(() {
      client = MockDio();
      users = UsersHandler(client: client);
    });

    test('that UsersHandler extends  ItemsHandler.', () async {
      final users = UsersHandler(client: MockDio());

      expect(users, isA<ItemsHandler>());
    });

    test('that `invite` works.', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      await users.invite(email: 'test@email.com', roleId: 'some-uuid');

      verify(client.post(
        'users/invite',
        data: {'email': 'test@email.com', 'role': 'some-uuid'},
      )).called(1);
    });

    test('that `inviteMany` works.', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      await users.inviteMany(
          emails: ['test@example.com', 'test2@example.com'], role: 'some-uuid');

      verify(client.post('users/invite', data: {
        'email': ['test@example.com', 'test2@example.com'],
        'role': 'some-uuid'
      })).called(1);
    });

    test('that `acceptInvite` works.', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      await users.acceptInvite(password: 'some-password', token: 'some-token');

      verify(client.post(
        'users/invite/accept',
        data: {'password': 'some-password', 'token': 'some-token'},
      )).called(1);
    });
  });
}
