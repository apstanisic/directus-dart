import 'package:dio/dio.dart';

/// Wrapper around data that is returned from API.
///
/// Most of Directus methods return [DirectusResponse].
class DirectusResponse<T> {
  /// Data returned from request
  late T data;
  DirectusResponse(Response dioResponse) {
    data = dioResponse.data['data'];
  }
}
