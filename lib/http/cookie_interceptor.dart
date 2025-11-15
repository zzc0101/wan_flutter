import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wan_flutter/constants.dart';
import 'package:wan_flutter/utils/sp_utils.dart';

class CookieInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 取出本地Cookie
    SpUtils.getList(Constants.SP_COOKIE_LIST).then((cookieList) {
      // 塞到请求头中
      options.headers[HttpHeaders.setCookieHeader] = cookieList;
      // 继续往下执行
      handler.next(options);
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.contains("user/login")) {
      // 取出 cookie信息
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList = [];
      if (list is List) {
        for (String? cookie in list) {
          cookieList.add(cookie ?? "");
          print("CookieInterceptor cookie = ${cookie.toString()}");
        }
      }
      SpUtils.saveStringList(Constants.SP_COOKIE_LIST, cookieList);
    }
    super.onResponse(response, handler);
  }
}
