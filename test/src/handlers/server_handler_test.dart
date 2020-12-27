// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_response.dart';
import 'package:directus/src/handlers/server_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  group('ServerHandler', () {
    late ServerHandler server;
    late Dio client;

    setUp(() {
      client = MockDio();
      server = ServerHandler(client: client);
    });

    test('that `ping` works.', () async {
      when(client.get(any)).thenAnswer((realInvocation) async => Response(data: 'pong'));

      final response = await server.ping();

      expect(response, 'pong');
      verify(client.get('/server/ping')).called(1);
    });

    test('that `info` works.', () async {
      when(client.get(any)).thenAnswer((realInvocation) async => Response(data: {'data': {}}));

      final response = await server.info();

      expect(response, isA<DirectusResponse>());
      expect(response.data, isA<Map>());

      verify(client.get('/server/info')).called(1);
    });

    test('hat `oas` works.', () async {
      when(client.get(any)).thenAnswer((realInvocation) async => Response(data: {'data': {}}));

      final response = await server.oas();

      expect(response, isA<DirectusResponse>());
      expect(response.data, isA<Map>());
      verify(client.get('/server/specs/oas')).called(1);
    });
  });
}
