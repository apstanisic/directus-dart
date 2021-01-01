// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';
import 'package:directus/src/utils/items_converter.dart';
import 'package:directus/src/utils/map_items_converter.dart';

/// Wrapper around data that is returned from API.
///
/// Most of Directus methods return [DirectusResponse].
class DirectusResponse<T> {
  /// Data returned from request
  late T data;

  /// Constructor that converts [Dio] [Response] to [DirectusResponse].
  DirectusResponse(Response dioResponse, {ItemsConverter? converter}) {
    converter ??= MapItemsConverter();
    var data = dioResponse.data['data'];

    if (data is List) {
      throw DirectusError(message: 'List should use DirectusListResponse.', code: 1000);
    } else if (data is Map<String, dynamic>) {
      this.data = converter.fromJson(data);
    } else {
      this.data = data;
    }
  }

  /// Set [DirectusResponse] manually, without needing [Response].
  DirectusResponse.manually(T data) : data = data;

  /// Static method that you can pass a closure that should return [Dio][Response].
  /// This will automaticaly convert [Response] to either [DirectusResponse] or [DirectusError].
  /// Most of the methods that return JSON object with key `data` should be called inside this
  /// static method.
  static Future<DirectusResponse<U>> fromRequest<U>(
    Future<Response<dynamic>> Function() f, {
    ItemsConverter? converter,
  }) async {
    converter ??= MapItemsConverter();
    try {
      final response = await f();
      return DirectusResponse<U>(response, converter: converter);
    } on DioError catch (error) {
      throw DirectusError.fromDio(error);
    }
  }
}

class DirectusListResponse<T> implements DirectusResponse<List<T>> {
  @override
  late final List<T> data;

  DirectusListResponse.manually(data) : data = data;

  /// Constructor that converts [Dio] [Response] to [DirectusResponse].
  DirectusListResponse(Response dioResponse, {ItemsConverter? converter}) {
    converter ??= MapItemsConverter();
    var data = dioResponse.data['data'];

    if (!(data is List)) {
      throw DirectusError(message: 'Data should be a list.', code: 1000);
    } else {
      this.data = data.map((item) => converter!.fromJson(item)).cast<T>().toList();
    }
  }

  /// Static method that you can pass a closure that should return [Dio][Response].
  /// This will automaticaly convert [Response] to either [DirectusResponse] or [DirectusError].
  /// Most of the methods that return JSON object with key `data` should be called inside this
  /// static method.
  static Future<DirectusListResponse<U>> fromRequest<U>(
    Future<Response<dynamic>> Function() f, {
    ItemsConverter? converter,
  }) async {
    converter ??= MapItemsConverter();
    try {
      final response = await f();
      return DirectusListResponse<U>(response, converter: converter);
    } on DioError catch (error) {
      throw DirectusError.fromDio(error);
    }
  }
}
