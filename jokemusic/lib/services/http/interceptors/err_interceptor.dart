import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //统一处理 error
    AppException appException = AppException.init(err);
    //错误提示
    debugPrint("dio error == ${appException.toString()}");

    err.copyWith(error: {err: appException});
    handler.next(err);

    // super.onError(err, handler);
  }
}

class AppException implements Exception {
  AppException({
    this.code,
    this.msg
  });

  final int? code;
  final String? msg;

  @override
  String toString() => "请求失败:$code$msg";

  factory AppException.init(DioException error){
    switch(error.type){
      case DioExceptionType.cancel:
        return AppException(code: -1, msg: "请求取消");
      case DioExceptionType.connectionTimeout:
        return AppException(code:-1, msg: "连接超时");
      case DioExceptionType.sendTimeout:
        return AppException(code: -1, msg: "请求超时");
      case DioExceptionType.receiveTimeout:
        return AppException(code: -1, msg: "响应超时");
      case DioExceptionType.unknown:
        return AppException(code: -1, msg: "未知错误");
      case DioExceptionType.badResponse:
        try{
          int errCode = error.response?.statusCode ?? -1;
          switch (errCode) {
            case 400:
              return AppException(code: errCode, msg: "请求语法错误");
            case 401:
              return AppException(code: errCode, msg: "没有权限");
            case 403:
              return AppException(code: errCode, msg: "服务器拒绝执行");
            case 404:
              return AppException(code: errCode, msg: "无法连接服务器");
            case 405:
              return AppException(code: errCode, msg: "请求方法被禁止");
            case 500:
              return AppException(code: errCode, msg: "服务器内部错误");
            case 502:
              return AppException(code: errCode, msg: "无效的请求");
            case 503:
              return AppException(code: errCode, msg: "服务器挂了");
            case 505:
              return AppException(code: errCode, msg: "不支持HTTP协议请求");
            default:
              return AppException(code: errCode, msg: error.response?.statusMessage ?? "未知错误");
          }
        } catch(e) {
          return AppException(code: -1, msg: "未知错误: ${e.toString()}");
        }
      default:
        return AppException(code: -1, msg: error.message);
    }
  }
}