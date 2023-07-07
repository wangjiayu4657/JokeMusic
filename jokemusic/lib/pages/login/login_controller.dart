import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/storage/storage.dart';
import '../../services/http/http.dart';
import '../../tools/share/user_manager.dart';
import '../../tools/extension/object_extension.dart';
import 'login_model.dart';

class LoginController extends GetxController {
  ///用户信息
  UserInfoModel? userInfoModel;
  ///用户名
  final userName = ''.obs;
  ///密码/验证码
  final password = ''.obs;
  ///是否为验证码登录
  final isCodeLogin = false.obs;
  ///是否为密码状态
  final obscureText = true.obs;
  ///验证码按钮是否可点
  final isCodeBtnEnable = false.obs;
  ///登录按钮是否能交互
  final isLoginBtnEnable = false.obs;
  late final textCtrl = TextEditingController();

  @override
  void onInit() {
    everAll([userName, password], (callback) {
      isCodeBtnEnable.value = userName.value.isPhoneNumber;
      isLoginBtnEnable.value = userName.isNotEmpty && password.isNotEmpty;
    });
    super.onInit();
  }

  @override
  void onClose() {
    textCtrl.dispose();
    super.onClose();
  }

  ///登录请求
  void loginRequest() {
    if(isCodeLogin.value) {
      loginCodeRequest(code: password.value, userName: userName.value, callback: Get.back);
    } else {
      loginPwdRequest(userName: userName.value, password: password.value, callback: Get.back);
    }
  }

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
    final result = await Http.post(url: url,params: params);

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
    final result = await Http.post(url: url, params: params);

    parseJsonData(result["data"]);
    callback != null ? callback() : null;
  }

  ///获取验证码
  void codeRequest() {
    if(userName.value.isPhoneNumber == false) {
      showToast("请输入正确的手机号码");
      return;
    }

    const url = "/user/login/get_code";
    final params = {"phone": userName.value};
    Http.post(url: url, params: params);
  }

  ///解析数据
  void parseJsonData(Map<String,dynamic> result) {
    //保存token
    String token = result["token"];
    Storage.save<String>("token", token);

    String type = result["type"].toString();
    final isLogin = (type == "login_success") || (type == "login_psw_success");
    UserManager.instance.saveLoginState(isLogin);

    //保存用户信息
    final userInfo = result["userInfo"];
    final userModel = UserInfoModel.fromJson(userInfo);
    UserManager.instance.saveUserInfo(userModel);

    userInfoModel = userModel;
  }
}