import 'package:dio/dio.dart';
import 'package:wan_flutter/http/http_method.dart';
import 'package:wan_flutter/http/print_log_interceptor.dart';
import 'package:wan_flutter/http/rsp_interceptor.dart';

import 'cookie_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTime = Duration(seconds: 30);

  void initDio({
    required String baseUrl,
    String? httpMethod = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTime,
      receiveTimeout: receiveTimeout ?? _defaultTime,
      sendTimeout: sendTimeout ?? _defaultTime,
    );
    // 添加Cookie拦截器
    _dio.interceptors.add(CookieInterceptor());
    // 添加打印请求返回信息拦截器
    _dio.interceptors.add(PrintLogInterceptor());
    // 添加统一返回值处理拦截器
    _dio.interceptors.add(ResponseInterceptor());
  }

  /// get请求方法
  Future<Response> get({
    required String path,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(
      path,
      queryParameters: param,
      options:
          options ??
          Options(
            method: HttpMethod.GET,
            receiveTimeout: _defaultTime,
            sendTimeout: _defaultTime,
          ),
      cancelToken: cancelToken,
    );
  }

  /// post请求方法
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(
      path,
      queryParameters: queryParameters,
      options:
          options ??
          Options(
            method: HttpMethod.POST,
            receiveTimeout: _defaultTime,
            sendTimeout: _defaultTime,
          ),
      cancelToken: cancelToken,
    );
  }

  void changeBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

}
