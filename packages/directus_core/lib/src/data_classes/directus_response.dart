import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';
import 'package:directus_core/src/modules/items/items_converter.dart';
import 'package:directus_core/src/modules/items/map_items_converter.dart';

/// Wrapper around data that is returned from API.
///
/// Most of Directus methods return [DirectusResponse].
class DirectusResponse<T> {
  /// Data returned from request
  late final T data;

  /// Constructor that converts [Dio] [Response] to [DirectusResponse].
  DirectusResponse(Response dioResponse, {ItemsConverter? converter}) {
    converter ??= MapItemsConverter();
    var data = dioResponse.data['data'];

    if (data is List) {
      throw DirectusError(message: 'List should use DirectusListResponse.');
    } else if (data is Map<String, Object?>) {
      this.data = converter.fromJson(data);
    } else {
      this.data = data;
    }
  }

  /// Set [DirectusResponse] manually, without needing [Response].
  DirectusResponse.manually(this.data);

  /// Static method that you can pass a closure that should return Dio [Response].
  ///
  /// This will automatically convert [Response] to either [DirectusResponse] or [DirectusError].
  /// Most of the methods that return JSON object with key `data` that is not a [List]
  /// should be called inside this static method.
  /// You can pass converter that is used to convert response [Map] to
  /// proper object, by default it will return [Map].
  static Future<DirectusResponse<U>> fromRequest<U>(
    Future<Response<Object?>> Function() func, {
    ItemsConverter? converter,
  }) async {
    converter ??= MapItemsConverter();
    try {
      final response = await func();
      return DirectusResponse<U>(response, converter: converter);
    } on DioError catch (error) {
      throw DirectusError.fromDio(error);
    }
  }
}
