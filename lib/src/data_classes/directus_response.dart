// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';

/// Wrapper around data that is returned from API.
///
/// Most of Directus methods return [DirectusResponse].
class DirectusResponse<T> {
  /// Data returned from request
  late T data;

  /// Constructor that converts [Dio] [Response] to [DirectusResponse].
  DirectusResponse(Response dioResponse) {
    var data = dioResponse.data['data'];

    if (data is List) {
      data = data.cast<Map>();
    }

    this.data = data;
  }

  /// Set [DirectusResponse] manually, without needing [Response].
  DirectusResponse.manually(T data) {
    this.data = data;
  }

  /// Static method that you can pass a closure that should return [Dio][Response].
  /// This will automaticaly convert [Response] to either [DirectusResponse] or [DirectusError].
  /// Most of the methods that return JSON object with key `data` should be called inside this
  /// static method.
  static Future<DirectusResponse<U>> fromRequest<U>(Future<Response<dynamic>> Function() f) async {
    try {
      final response = await f();
      return DirectusResponse<U>(response);
    } on DioError catch (error) {
      throw DirectusError.fromDio(error);
    }
  }
}
