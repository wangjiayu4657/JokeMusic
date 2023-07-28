import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Profile/user_info_editor_page.dart';


class UserInfoEditorController extends GetxController {
  late EditType editType = EditType.nickname;
  late String? nickname;
  late String? signature;
  late String desc = "";
  late final textCtrl = TextEditingController();
  String get title => editType == EditType.nickname ?"修改昵称" : "修改签名";
  String get placeholder => editType == EditType.nickname ? nickname ?? "请输入昵称" : signature ?? "请输入签名";

  @override
  void onInit() {
    editType = Get.arguments["type"];
    nickname = Get.arguments["nickname"];
    signature = Get.arguments["signature"];
    textCtrl.text = placeholder;
    super.onInit();
  }

  @override
  void onClose() {
    textCtrl.dispose();
    super.onClose();
  }

  void inputText(dynamic text){
    desc = text;
  }
}

class UserInfoEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserInfoEditorController>(() => UserInfoEditorController());
  }
}