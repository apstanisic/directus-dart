import 'package:directus_core/src/data_classes/directus_response.dart';
import 'package:directus_core/src/modules/server_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock/mock_dio_response.dart';
import '../mock/mocks.mocks.dart';

void main() {
  group('ServerHandler', () {
    late ServerHandler server;
    late MockDio client;

    setUp(() {
      client = MockDio();
      server = ServerHandler(client: client);
    });

    test('that `ping` works.', () async {
      when(client.get(any)).thenAnswer(dioResponse('pong'));

      final response = await server.ping();

      expect(response, 'pong');
      verify(client.get('server/ping')).called(1);
    });

    test('that `info` works.', () async {
      when(client.get(any)).thenAnswer(dioResponse({'data': {}}));

      final response = await server.info();

      expect(response, isA<DirectusResponse>());
      expect(response.data, isA<Map>());

      verify(client.get('server/info')).called(1);
    });

    test('hat `oas` works.', () async {
      when(client.get(any)).thenAnswer(dioResponse({'data': {}}));

      final response = await server.oas();

      expect(response, isA<DirectusResponse>());
      expect(response.data, isA<Map>());
      verify(client.get('server/specs/oas')).called(1);
    });
  });
}
