import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockInterceptors extends Mock implements Interceptors {}

class MockDio extends Mock implements Dio {
  final _mockInterceptors = MockInterceptors();
  @override
  Interceptors get interceptors => _mockInterceptors;

  @override
  BaseOptions get options => BaseOptions(baseUrl: '');
}
