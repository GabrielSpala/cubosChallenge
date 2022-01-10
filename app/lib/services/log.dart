import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
        'REQUEST[${options.method}] => PATH: ${options.path} ${options.queryParameters.toString()}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} ${response.requestOptions.queryParameters.toString()}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path} ${err.requestOptions.queryParameters.toString()}',
    );
    return super.onError(err, handler);
  }
}
