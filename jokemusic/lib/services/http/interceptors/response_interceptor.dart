import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart' as get_tool;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../response/app_exception.dart';
import '../response/base_response.dart';
import '../../storage/storage.dart';
import '../../../pages/login/login_view.dart';
import '../../../tools/share/user_manager.dart';

///定义一个响应拦截器
class ResponseInterceptor extends InterceptorsWrapper {
  bool isLoading = true;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("请求拦截: \n url = ${options.uri} \n param = ${options.queryParameters}");

    //打开加载窗
    if(isLoading) SmartDialog.showLoading();

    //添加token
    String? token = await Storage.fetchString("token");
    // debugPrint("token === $token");
    if(token.isNotEmpty) options.headers.addAll({"token": token});

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    //关闭弹窗
    if (isLoading && SmartDialog.config.isExistLoading) {
      await SmartDialog.dismiss(status: SmartStatus.loading);
    }

    //处理最外层数据结构
    BaseResponse bean = BaseResponse.fromJson(response.data);
    response.data = bean;
    debugPrint("response  ===  ${bean.data}");
    _handlerResponse(bean);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //关闭弹窗
    if(isLoading && SmartDialog.config.isExistLoading){
      await SmartDialog.dismiss(status: SmartStatus.loading);
    }

    //统一处理 error
    AppException appException = AppException.init(err);
    err.copyWith(error: {err: appException});

    handler.next(err);
  }

  ///处理token失效的问题
  void _handlerResponse(BaseResponse result){
    final msg = result.msg ?? "";
    if(result.code == 0) {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg);
    } else if(result.code == 202) {   //登录过期
      UserManager.instance.saveLoginState(false);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg);
      get_tool.Get.toNamed(LoginPage.routeName);
    }
  }
}
