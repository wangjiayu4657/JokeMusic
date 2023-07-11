import 'package:get/get.dart';

import '../../../services/http/http.dart';
import '../../../tools/extension/object_extension.dart';

class ChangePasswordController extends GetxController {
  late String oldPwd = '';
  late String newPwd = '';
  late String surePwd = '';
  late bool obscureText = false;

  bool get isChangeBtnEnable => oldPwd.isNotEmpty == true &&
                                newPwd.isNotEmpty == true &&
                                surePwd.isNotEmpty == true;

  ///输入原始密码
  void original(dynamic password){
    oldPwd = password ?? '';
    update();
  }

  ///预期密码
  void target(dynamic password){
    newPwd = password ?? '';
    update();
  }

  ///确认密码
  void confirm(dynamic password){
    surePwd = password ?? '';
    update();
  }

  void toggle() {
    obscureText = !obscureText;
    update();
  }

  ///修改密码
  void changeRequest() async {
    const url = "/user/psw/change";
    final param = {"old_psw": oldPwd, "password": newPwd, "new_psw": surePwd};
    final result = await Http.post(url: url, params: param);
    final code = result["code"];
    final msg = result["msg"].toString();

    showToast(msg);
    if(code == 200) Get.back();
  }
}

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}