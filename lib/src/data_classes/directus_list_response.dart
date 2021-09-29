import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_converter.dart';
import 'package:directus/src/modules/items/map_items_converter.dart';

import 'data_classes.dart';

/// Directus response object when data is [List].
///
/// When response is returning a [List] of items, use this instead of [DirectusResponse].
/// This class is created to properly and type safely convert data.
/// Using [List] responses inside [DirectusResponse] will throw an error. Only this
/// response should be used. It has all the same properties and methods,
/// but adopted when response is [List].
class DirectusListResponse<T> implements DirectusResponse<List<T>> {
  /// Response data.
  @override
  late final List<T> data;

  /// Response metadata.
  late final _Meta? meta;

  /// Manually set data.
  DirectusListResponse.manually(data, {this.meta}) : data = data;

  /// Constructor that converts Dio [Response] to [DirectusListResponse].
  /// You can pass converter that is used to convert response [Map] to
  /// proper object, by default it will return [Map].
  DirectusListResponse(Response dioResponse, {ItemsConverter? converter}) {
    converter ??= MapItemsConverter();
    var data = dioResponse.data['data'];
    meta = _Meta.fromJson(dioResponse.data['meta']);

    if (!(data is List)) {
      throw DirectusError(message: 'Data should be a list.');
    }
    this.data =
        data.map((item) => converter!.fromJson(item)).cast<T>().toList();
  }

  /// Static method that you can pass a closure that should return Dio [Response].
  ///
  /// This will automaticaly convert [Response] to either [DirectusListResponse] or [DirectusError].
  /// Most of the methods that return JSON object with key `data` that is [List]
  /// should be called inside this method.
  /// You can pass converter that is used to convert response [Map] to
  /// proper object, by default it will return [Map].
  static Future<DirectusListResponse<U>> fromRequest<U>(
    Future<Response<Object?>> Function() func, {
    ItemsConverter? converter,
  }) async {
    converter ??= MapItemsConverter();
    try {
      final response = await func();
      return DirectusListResponse<U>(response, converter: converter);
    } on DioError catch (error) {
      throw DirectusError.fromDio(error);
    }
  }
}

/// Response metadata
class _Meta {
  int? totalCount;
  int? filterCount;

  _Meta({this.filterCount, this.totalCount});

  _Meta.fromJson(Map<String, Object?>? data)
      : totalCount = data?['total_count'] as int?,
        filterCount = data?['filter_count'] as int?;
}
