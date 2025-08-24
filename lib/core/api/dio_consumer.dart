import 'package:dio/dio.dart';
import 'api_consumer.dart';


class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options
      // ..baseUrl = EndPoints.baseUrl
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 60);
    // dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var options = Options(headers: headers);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var options = Options(headers: headers);
    var response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  @override
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var options = Options(headers: headers);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  @override
  Future put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var options = Options(headers: headers);
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  @override
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    var options = Options(headers: headers);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }
}
