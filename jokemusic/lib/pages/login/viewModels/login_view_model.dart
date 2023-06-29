import 'package:flutter/material.dart';

import '../../../services/storage/storage.dart';
import '../../../services/http/http_client.dart';
import '../../../tools/share/user_manager.dart';
import '../../../tools/extension/object_extension.dart';
import '../../../pages/login/models/user_info_model.dart';

class LoginViewModel {

  ///是否登录成功
  late bool isLogin = false;
  ///用户信息
  UserInfoModel? userInfoModel;

  ///密码登录请求
  void loginPwdRequest({String? userName, String? password, VoidCallback? callback}) async {

    if(userName == null) {
      showToast("请输入账户名");
      return;
    }

    if(password == null) {
      showToast("请输入密码");
      return;
    }

    const url = "/user/login/psw";
    final params = {"phone": userName, "psw": password};
    final result = await HttpClient.request(url: url,params: params);

    parseJsonData(result["data"]);
    callback != null ? callback() : null;
  }

  ///验证码登录请求
  void loginCodeRequest({String? userName, String? code, VoidCallback? callback}) async {
    if(userName == null) {
      showToast("请输入账户名");
      return;
    }

    if(code == null) {
      showToast("请输入验证码");
      return;
    }

    const url = "/user/login/code";
    final params = {"phone": userName, "code": code};
    final result = await HttpClient.request(url: url, params: params);

    parseJsonData(result["data"]);
    callback != null ? callback() : null;
  }

  ///获取验证码
  void codeRequest({String? phone}) {
    const url = "/user/login/get_code";
    final params = {"phone":phone};
    HttpClient.request(url: url, params: params);
  }

  ///解析数据
  void parseJsonData(Map<String,dynamic> result) {
    //保存token
    String token = result["token"];
    Storage.save<String>("token", token);

    String type = result["type"].toString();
    isLogin = (type == "login_success") || (type == "login_psw_success");
    UserManager.instance.saveLoginState(isLogin);

    //保存用户信息
    final userInfo = result["userInfo"];
    final userModel = UserInfoModel.fromJson(userInfo);
    UserManager.instance.saveUserInfo(userModel);

    userInfoModel = userModel;
  }
}