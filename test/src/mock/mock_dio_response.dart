import 'package:dio/dio.dart';

typedef Res = Future<Response<Object?>> Function(Invocation);

/// This function is used to set response when mocking [Dio] request.
///
/// Mockito's `thenAnwser` expects function, this wrapper function returns
/// that function that will return response with data that is passed to [dioResponse].
Res dioResponse([Object? data]) {
  return (Invocation invocation) async => Response(
        data: data,
        requestOptions: RequestOptions(path: '/'),
      );
}
