import '../../../tools/share/device_manager.dart';

///网络配置
class NetConfig {
  //禁止实例化NetConfig类
  NetConfig._();

  ///发送超时时间15s
  static const int sendTimeout = 15000;
  ///连接超时时间15s
  static const int connectTimeout = 15000;
  ///接收超时时间15s
  static const int receiveTimeout = 15000;

  ///设置base url
  static const String baseUrl = "http://tools.cretinzp.com/jokes";

  ///请求内容类型 form, UTF-8
  static const String contentType = "application/json";

  ///设置请求头
  static Map<String,dynamic> headers = {
    "project_token":"BBA5BF6858194BCCA6EE6EA5903E8878",
    "uk": DeviceManager.uk,
    "channel":"cretin_open_api",
    "app": DeviceManager.app,
    "device": DeviceManager.device
  };
}