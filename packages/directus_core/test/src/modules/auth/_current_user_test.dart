import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_response.dart';
import 'package:directus_core/src/modules/auth/_current_user.dart';
import 'package:directus_core/src/modules/users/directus_user.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio_response.dart';
import '../../mock/mocks.mocks.dart';

void main() {
  group('CurrentUser', () {
    late Dio client;
    late CurrentUser currentUser;

    setUp(() {
      client = MockDio();
      currentUser = CurrentUser(client: client);
    });

    test('that `read` works.', () async {
      when(client.get('users/me')).thenAnswer(dioResponse({
        'data': {'id': '1'}
      }));

      final response = await currentUser.read();

      expect(response, isA<DirectusResponse>());
      expect(response.data, isA<DirectusUser>());
      expect(response.data.id, '1');
      verify(client.get('users/me')).called(1);
    });

    test('that `update` works.', () async {
      when(client.patch('users/me', data: anyNamed('data'))).thenAnswer(
        dioResponse({
          'data': {'id': '1', 'first_name': 'Test'}
        }),
      );
      final testUser = DirectusUser(email: 'test@email.com');

      final response = await currentUser.update(data: testUser);

      verify(client.patch('users/me', data: {'email': 'test@email.com'}))
          .called(1);

      expect(response, isA<DirectusResponse>());
      expect(response.data, isA<DirectusUser>());
      expect(response.data.toJson(), {
        'id': '1',
        'first_name': 'Test',
      });
    });
  });
}
