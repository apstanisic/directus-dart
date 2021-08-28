import 'package:dio/dio.dart';
import 'package:directus/directus.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:directus/src/modules/handlers.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
    [ItemsHandler, DirectusStorage, Dio, BaseOptions, AuthStorage, RequestInterceptorHandler])
void main() {}
