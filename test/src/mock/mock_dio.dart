import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {
  @override
  Interceptors get interceptors => Interceptors();

  @override
  BaseOptions get options => BaseOptions(baseUrl: '');
}
