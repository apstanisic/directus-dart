import 'package:dio/dio.dart';
import 'package:directus/src/modules/auth/_auth_response.dart';

import '_auth_storage.dart';

class AuthRefresh extends Interceptor {
  AuthRefresh({
    required Dio refreshClient,
    required AuthStorage storage,
    required this.logoutCallback,
  })  : _refreshClient = refreshClient,
        _storage = storage;

  final Dio _refreshClient;
  final AuthStorage _storage;
  final Future<void> Function() logoutCallback;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await _storage.getLoginData();
    final headers = currentToken != null
        ? _tokenHeader(currentToken.accessToken)
        : const <String, String>{};
    options.headers.addAll(headers);
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final token = await _storage.getLoginData();
    if (token == null || !_defaultShouldRefresh(response)) {
      return handler.next(response);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      return handler.resolve(refreshResponse);
    } on DioError catch (error) {
      return handler.reject(error);
    }
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final token = await _storage.getLoginData();
    if (response == null ||
        token == null ||
        err.error is RevokeTokenException ||
        !_defaultShouldRefresh(response)) {
      return handler.next(err);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      return handler.resolve(refreshResponse);
    } on DioError catch (error) {
      return handler.next(error);
    }
  }

  Future<AuthResponse> _refreshToken() async {
    final tokens = await _storage.getLoginData();
    if (tokens == null) {
      throw RevokeTokenException();
    }
    try {
      final response = await _refreshClient.post(
        'auth/refresh',
        data: {
          'mode': 'json',
          'refresh_token': tokens.refreshToken,
        },
      );
      final loginDataResponse = AuthResponse.fromResponse(response);
      return Future<AuthResponse>.value(loginDataResponse);
    } catch (_) {
      throw RevokeTokenException();
    }
  }

  Future<Response<Object?>> _tryRefresh(Response response) async {
    late final AuthResponse refreshedToken;
    try {
      refreshedToken = await _refreshToken();
    } on RevokeTokenException catch (error) {
      await logoutCallback();
      throw DioError(
        requestOptions: response.requestOptions,
        error: error,
        response: response,
      );
    }

    await _storage.storeLoginData(refreshedToken);
    _refreshClient.options.baseUrl = response.requestOptions.baseUrl;
    return await _refreshClient.request<Object?>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers
          ..addAll(_tokenHeader(refreshedToken.accessToken)),
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError:
            response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }

  static Map<String, Object> _tokenHeader(String accessToken) {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }

  static bool _defaultShouldRefresh(Response? response) {
    return response?.statusCode == 401 || response?.statusCode == 403;
  }
}

/// An Exception that should be thrown when overriding `refreshToken` if the
/// refresh fails and should result in a force-logout.
class RevokeTokenException implements Exception {}
