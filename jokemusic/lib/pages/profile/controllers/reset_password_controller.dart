import 'package:get/get.dart';

import '../../../services/http/http.dart';
import '../../../tools/extension/object_extension.dart';

class ResetPasswordController extends GetxController {
  String? code;
  String? phone;
  String? password;
  bool obscureText = false;

  bool get isCodeBtnEnable {
    return (phone != null) && (phone?.length == 11);
  }

  bool get isResetBtnEnable {
    return phone?.isNotEmpty == true &&
        code?.isNotEmpty == true &&
        password?.isNotEmpty == true;
  }

  void inputPhoneNum(dynamic phone){
    this.phone = phone;
    update();
  }

  void inputCode(dynamic code){
    this.code = code;
    update();
  }

  void inputPassword(dynamic password){
    this.password = password;
    update();
  }

  void reverseObscureText() {
    obscureText = !obscureText;
    update();
  }

  ///获取验证码
  void codeBtnClick() {
    if(isCodeBtnEnable == false) return;
    const url = "/user/psw/reset/get_code";
    final params = {"phone": phone};
    Http.post(url: url, params: params);
  }

  ///重置密码
  void resetBtnClick() async {
    if(isCodeBtnEnable == false) return;
    const url = "/user/psw/reset";
    final params = {"code":code, "password":password, "phone":phone };
    final result = await Http.post(url: url, params: params);
    showToast(result.msg);
    if(result.code == 200) Get.back();
  }
}

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}