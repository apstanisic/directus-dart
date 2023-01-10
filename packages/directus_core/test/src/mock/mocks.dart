import 'package:dio/dio.dart';
import 'package:directus_core/directus_core.dart';
import 'package:directus_core/src/modules/auth/_auth_storage.dart';
import 'package:directus_core/src/modules/handlers.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ItemsHandler,
  DirectusStorage,
  Dio,
  BaseOptions,
  AuthStorage,
  RequestInterceptorHandler,
])
void main() {}
