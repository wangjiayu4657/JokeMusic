import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/input.dart';
import '../../common/custom_button.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../profile/controllers/user_info_editor_controller.dart';

enum EditType {
  ///昵称
  nickname,
  ///签名
  signature
}


///用户信息编辑页
class UserInfoEditorPage extends GetView<UserInfoEditorController> {
  static const String routeName = "/profile/user_info/user_info_editor";
  const UserInfoEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: _bodyView(children: [

        //文本输入视图
        _inputView(),

        //保存按钮
        _saveButton()
      ]),
    );
  }

  Widget _bodyView({required List<Widget> children}) {
    return Container(
      color: ColorExtension.bgColor,
      child: Column(
        children: children,
      ),
    );
  }

  ///内容输入框
  Widget _inputView() {
    return Container(
      height: 120.px,
      margin: EdgeInsets.only(top: 15.px, bottom: 15.px),
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px)
      ),
      child: Input(
        maxLines: null,
        controller: controller.textCtrl,
        placeholder: controller.placeholder,
        valueChanged: controller.inputText
      )
    );
  }

  ///保存按钮
  Widget _saveButton() {
    return CustomButton(
      title: "保存",
      height: 44.px,
      width: width - 30.px,
      radius: 8.px,
      style: const TextStyle(color: Colors.white),
      backgroundColor: Colors.orangeAccent,
      onPressed: () => Get.back<String>(result: controller.desc),
    );
  }
}
