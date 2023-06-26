import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'http_config.dart';
import '../../services/storage/storage.dart';
import '../../tools/share/user_manager.dart';
import '../../tools/share/device_manager.dart';

class HttpClient {
  static final baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: HttpConfig.timeout)
  );
  static Dio dio = Dio(baseOptions);

  static Future<T> request<T> ({
    required String url,
    String method = "post",
    Map<String,dynamic>? params,
    Interceptor? interceptor
  }) async {
    String? token = await Storage.fetchString("token");
    Map<String,dynamic> headers = {
      "project_token":"BBA5BF6858194BCCA6EE6EA5903E8878",
      "token": token,
      "uk": DeviceManager.uk,
      "channel":"cretin_open_api",
      "app": DeviceManager.app,
      "device": DeviceManager.device
    };

    final Options options = Options(method: method,headers: headers);

    //添加全局拦截器
    Interceptor globalInterceptor = InterceptorsWrapper(
      onRequest: (options,handler) {
        debugPrint("请求拦截: \n url = ${options.uri} \n param = ${options.queryParameters}");
        handler.next(options);
      },
      onResponse: (response,handler) {
        debugPrint("响应拦截: ${response.data}");
        handler.next(response);
        final param = response.data;
        final code = param["code"];
        final msg = param["msg"];
        if(code == 202) {
          UserManager.instance.saveLoginState(false);
          Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg);

        }
      },
      onError: (error,handler){
        debugPrint("错误拦截: ${error.error}");
        handler.next(error);
      }
    );

    List<Interceptor> interceptors = [globalInterceptor];
    if(interceptor != null) {
      interceptors.add(interceptor);
    }

    dio.interceptors.addAll(interceptors);
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioException catch(err) {
      return Future.error(err);
    }
  }
}



//https://jdmall.itying.com/api/pcontent?id=59f6a2d27ac40b223cfdcf81