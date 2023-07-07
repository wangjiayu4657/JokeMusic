import 'dart:async';
import 'package:dio/dio.dart';
import 'net_config.dart';

import '../interceptors/response_interceptor.dart';

enum HttpMethod {
  ///Get
  get,

  ///Post
  post,

  ///Put
  put,

  ///Delete
  delete
}

///网络封装
class NetUtil {
  static NetUtil? _instance;
  static NetUtil get instance => _instance ??= NetUtil._internal();
  factory NetUtil() => instance;

  Dio dio = Dio();
  final CancelToken _cancelToken = CancelToken();
  static final ResponseInterceptor _responseInterceptor = ResponseInterceptor();

  NetUtil._internal() {
    dio.options = BaseOptions(
      //设置base url
      baseUrl: NetConfig.baseUrl,
      //设置请求头
      headers: NetConfig.headers,
      //设置请求类型
      contentType: NetConfig.contentType,
      //发送超时
      sendTimeout: const Duration(seconds: NetConfig.sendTimeout),
      //连接超时
      connectTimeout: const Duration(seconds: NetConfig.connectTimeout),
      //接收超时
      receiveTimeout: const Duration(seconds: NetConfig.receiveTimeout),
    );

    // //添加日志拦截
    // dio.interceptors.add(LogInterceptor());
    // //处理通用实体
    dio.interceptors.add(_responseInterceptor);
  }

  void init({
    required String baseUrl,
    int? sendTimeout,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }){
    //初始化默认参数
    dio.options.baseUrl = baseUrl;
    dio.options.sendTimeout = Duration(milliseconds: sendTimeout ?? NetConfig.sendTimeout);
    dio.options.connectTimeout = Duration(milliseconds: connectTimeout ?? NetConfig.connectTimeout);
    dio.options.receiveTimeout = Duration(milliseconds: receiveTimeout ?? NetConfig.receiveTimeout);

    //添加拦截器
    if(interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  ///Request 操作
  Future<T> request<T>({
    required String url,
    required HttpMethod method,
    dynamic data,
    Map<String,dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isLoading = true
  }) async {
    _responseInterceptor.isLoading = isLoading;

    //处理网络类型
    if(method == HttpMethod.get){
      dio.options.method = "GET";
    } else if(method == HttpMethod.post){
      dio.options.method = "POST";
    } else if(method == HttpMethod.put){
      dio.options.method = "PUT";
    } else if(method == HttpMethod.delete){
      dio.options.method = "DELETE";
    }

    options = options ??  Options();
    Completer<T> completer = Completer();
    dio.request<T>(
      url,
      data: data,
      queryParameters: params,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress
    ).then((value) => completer.complete(value.data)
    ).catchError((err) {
      completer.complete();
      completer.completeError(err);
    }).whenComplete(() => null);

    return completer.future;
  }

  ///添加拦截器
  void addInterceptor(Interceptor interceptor) {
    //一种类型的拦截器只能添加一次
    if (dio.interceptors.contains(interceptor)) return;
    dio.interceptors.add(interceptor);
  }

  ///移除拦截器
  void removeInterceptor(Interceptor interceptor){
    dio.interceptors.remove(interceptor);
  }

  ///设置header
  void setHeaders(Map<String,dynamic> map) async {
    dio.options.headers.addAll(map);
  }

  ///移除header
  void removeHeader(String? key){
    dio.options.headers.remove(key);
  }

  /// 取消请求
  /// 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
  /// 所以参数可选
  void cancelRequest({CancelToken? cancelToken}){
    cancelToken ?? _cancelToken.cancel("cancelled");
  }
}