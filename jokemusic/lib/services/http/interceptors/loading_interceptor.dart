import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

///定义一个加载弹窗拦截器
class LoadingInterceptor extends Interceptor {
  bool isLoading = true;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //打开加载窗
    if(isLoading) SmartDialog.showLoading();
    handler.next(options);
    debugPrint("url ==*==  ${options.uri}");
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    //关闭弹窗
    if(isLoading && SmartDialog.config.isExistLoading){
      await SmartDialog.dismiss(status: SmartStatus.loading);
    }
    handler.next(response);
    // super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //关闭弹窗
    if(isLoading && SmartDialog.config.isExistLoading){
      await SmartDialog.dismiss(status: SmartStatus.loading);
    }
    handler.next(err);
    // super.onError(err, handler);
  }
}