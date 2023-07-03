import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../response/base_response.dart';

///定义一个响应拦截器
class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("请求拦截: \n url = ${options.uri} \n param = ${options.queryParameters}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //处理最外层数据结构
    BaseResponse bean = BaseResponse.fromJson(response.data);
    response.data = bean.data;
    debugPrint("response  ===  ${response.data}");
    handler.next(response);
  }
}