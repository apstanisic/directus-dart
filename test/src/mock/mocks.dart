import 'package:dio/dio.dart';
import 'package:directus/directus.dart';
import 'package:directus/src/modules/handlers.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // Dio,
  ItemsHandler,
  // DirectusStorage
], customMocks: [
  MockSpec<Dio>(returnNullOnMissingStub: true),
  // MockSpec<ItemsHandler>(returnNullOnMissingStub: true),
  MockSpec<DirectusStorage>(returnNullOnMissingStub: true),
])
main() {}
