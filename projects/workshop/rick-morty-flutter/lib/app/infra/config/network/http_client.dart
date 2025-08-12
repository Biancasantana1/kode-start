import 'package:dio/dio.dart';

import '../../infra.dart';

class HttpClient implements IHttpClient {
  final Dio _dio;

  HttpClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://rickandmortyapi.com/api/',
            headers: {'Content-Type': 'application/json'},
            validateStatus: (status) => true,
          ),
        ) {
    _dio.interceptors.addAll([
      LogInterceptor(responseBody: true),
    ]);
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
