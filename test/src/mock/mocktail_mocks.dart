import 'package:dio/dio.dart';
import 'package:directus/directus.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:directus/src/modules/handlers.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsHandler extends Mock implements ItemsHandler {}

class MockDirectusStorage extends Mock implements DirectusStorage {}

class MockDio extends Mock implements Dio {}

class MockAuthStorage extends Mock implements AuthStorage {}
