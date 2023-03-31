import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'http_config.dart';

class HttpClient {
  static final baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    contentType: 'application/json',
    connectTimeout: HttpConfig.timeout
  );
  static Dio dio = Dio(baseOptions);

  static Future<T> request<T> ({
    required String url,
    String method = "get",
    Map<String,dynamic>? params,
    Interceptor? interceptor
  }) async {

    final Options options = Options(method: method);

    //添加全局拦截器
    Interceptor globalInterceptor = InterceptorsWrapper(
      onRequest: (options,handler) {
        debugPrint("请求拦截: \n url = ${options.uri} \n param = ${options.queryParameters}");
        handler.next(options);
      },
      onResponse: (response,handler) {
        debugPrint("响应拦截: ${response.data}");
        handler.next(response);
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
    } on DioError catch(err) {
      return Future.error(err);
    }
  }
}



//https://jdmall.itying.com/api/pcontent?id=59f6a2d27ac40b223cfdcf81