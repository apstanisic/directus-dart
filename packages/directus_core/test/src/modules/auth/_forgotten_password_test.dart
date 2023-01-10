import 'package:directus_core/src/modules/auth/_forgotten_password.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio_response.dart';
import '../../mock/mocks.mocks.dart';

void main() {
  late MockDio client;
  late ForgottenPassword fp;
  setUp(() {
    client = MockDio();
    fp = ForgottenPassword(client: client);
  });

  group('ForgottenPassword', () {
    test('requestPassword', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());
      await fp.request('email@test.com');
      verify(client.post('auth/password/request',
          data: {'email': 'email@test.com'})).called(1);
    });

    test('requestPassword', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      await fp.reset(token: 'token1', password: 'password1');

      verify(client.post('auth/password/reset',
          data: {'token': 'token1', 'password': 'password1'})).called(1);
    });
  });
}
