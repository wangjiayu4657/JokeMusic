import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../account_safe_page.dart';
import '../../../services/routes/route_name_config.dart';

class AccountSafeController extends GetxController {
  final List<String> list = ["当前绑定手机号","重置密码","修改密码","绑定QQ","绑定新浪微博","注销账号"];

  void handlerItemSelected(int idx) {
    switch(idx){
      case 1:
        Get.toNamed(RouteName.resetPassword);
        break;
      case 2:
        Get.toNamed(RouteName.changePassword);
        break;
      case 3:
        debugPrint("绑定QQ");
        break;
      case 4:
        debugPrint("绑定新浪微博");
        break;
      case 5:
        Get.dialog(const CancelOutAlertView());
        break;
      default:
        debugPrint("手机号码");
        break;
    }
  }
}

class AccountSafeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSafeController>(() => AccountSafeController());
  }
}