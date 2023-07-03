import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as get_result;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'http_config.dart';
import '../../pages/login/login_view.dart';
import '../../services/http/net/net_util.dart';
import 'net/net_config.dart';
import '../../services/storage/storage.dart';
import '../../tools/share/user_manager.dart';
import '../../tools/share/device_manager.dart';


class Http {
  void init({
    required String baseUrl,
    int? sendTimeout,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }){
    NetUtil.instance.init(
      baseUrl: baseUrl,
      sendTimeout: sendTimeout,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors
    );
  }

  ///Get 操作
  static Future<T> get<T> ({
    required String url,
    Map<String,dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool isLoading = true,
  }) async {
    final response = await request(
      url: url,
      method: HttpMethod.get,
      params: params,
      options: options,
      cancelToken: cancelToken,
      isLoading: isLoading
    );
    return response;
  }

  ///Post 操作
  static Future<T> post<T> ({
    required String url,
    dynamic data,
    Map<String,dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool isLoading = true,
  }) async {
    final response = await request(
      url: url,
      data: data,
      method: HttpMethod.post,
      params: params,
      options: options,
      cancelToken: cancelToken,
      isLoading: isLoading
    );
    print("response ==*== $response");
    return response;
  }

  ///Put 操作
  static Future<T> put<T> ({
    required String url,
    dynamic data,
    Map<String,dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool isLoading = true,
  }) async {
    final response = await request(
      url: url,
      data: data,
      method: HttpMethod.put,
      params: params,
      options: options,
      cancelToken: cancelToken,
      isLoading: isLoading
    );
    return response;
  }

  ///Delete 操作
  static Future<T> delete<T> ({
    required String url,
    dynamic data,
    Map<String,dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool isLoading = true,
  }) async {
    final response = await request(
      url: url,
      data: data,
      method: HttpMethod.delete,
      params: params,
      options: options,
      cancelToken: cancelToken,
      isLoading: isLoading
    );
    return response;
  }

  /// Request 操作
  /// Put、Delete请求之类都请使用Request请求
  /// 所有类型请求,都是调用此请求
  static Future request({
    required String url,
    dynamic data,
    HttpMethod method = HttpMethod.post,
    bool isLoading = true,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    print("url === $url, params === $params, method === $method");
    var response = await NetUtil.instance.request(
      url: url,
      data: data,
      method: method,
      params: params,
      options: options,
      isLoading: isLoading,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response;
  }

  ///设置请求头
  static void setHeaders(Map<String, dynamic> map) {
    NetUtil.instance.setHeaders(map);
  }

  ///设置取消token
  static void cancelRequests({CancelToken? cancelToken}) {
    NetUtil.instance.cancelRequest(cancelToken: cancelToken);
  }

  ///添加拦截器
  void addInterceptor(Interceptor interceptor) {
    //一种类型的拦截器只能添加一次
    NetUtil.instance.addInterceptor(interceptor);
  }

  ///移除拦截器
  void removeInterceptor(Interceptor interceptor){
    NetUtil.instance.removeInterceptor(interceptor);
  }

  /// 取消请求
  /// 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
  /// 所以参数可选
  void cancelRequest({CancelToken? cancelToken}){
    NetUtil.instance.cancelRequest(cancelToken: cancelToken);
  }
}


//
// class HttpClient {
//   static final baseOptions = BaseOptions(
//     baseUrl: HttpConfig.baseUrl,
//     contentType: 'application/json',
//     connectTimeout: const Duration(seconds: HttpConfig.timeout)
//   );
//   static Dio dio = Dio(baseOptions);
//
//   static Future<T> request<T> ({
//     required String url,
//     String method = "post",
//     Map<String,dynamic>? params,
//     Interceptor? interceptor
//   }) async {
//     String? token = await Storage.fetchString("token");
//     Map<String,dynamic> headers = {
//       "project_token":"BBA5BF6858194BCCA6EE6EA5903E8878",
//       "token": token,
//       "uk": DeviceManager.uk,
//       "channel":"cretin_open_api",
//       "app": DeviceManager.app,
//       "device": DeviceManager.device
//     };
//
//     final Options options = Options(method: method,headers: headers);
//
//     //添加全局拦截器
//     Interceptor globalInterceptor = InterceptorsWrapper(
//       onRequest: (options,handler) {
//         debugPrint("请求拦截: \n url = ${options.uri} \n param = ${options.queryParameters}");
//         handler.next(options);
//       },
//       onResponse: (response,handler) {
//         debugPrint("响应拦截: ${response.data}");
//         handler.next(response);
//         handlerResponse(response.data);
//       },
//       onError: (error,handler){
//         debugPrint("错误拦截: ${error.error}");
//         handler.next(error);
//       }
//     );
//
//     List<Interceptor> interceptors = [globalInterceptor];
//     if(interceptor != null) {
//       interceptors.add(interceptor);
//     }
//
//     dio.interceptors.addAll(interceptors);
//     try {
//       Response response = await dio.request(url, queryParameters: params, options: options);
//       return response.data;
//     } on DioException catch(err) {
//       return Future.error(err);
//     }
//   }
//
//   static void handlerResponse(dynamic result){
//     debugPrint("http response = $result");
//     final code = result["code"];
//     final msg = result["msg"];
//     if(code == 0) {
//       Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg);
//     } else if(code == 202) {   //登录过期
//       UserManager.instance.saveLoginState(false);
//       Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg);
//       get_result.Get.toNamed(LoginPage.routeName);
//     }
//   }
// }



//https://jdmall.itying.com/api/pcontent?id=59f6a2d27ac40b223cfdcf81