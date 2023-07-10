import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/change_password_controller.dart';
import '../../common/input.dart';
import '../../common/user_notice.dart';
import '../../common/custom_bottom_sheet.dart';
import '../../services/theme/theme_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  static const String routeName = "/change_password";

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: const UserNotice(),
    );
  }

  ///构建导航组件
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: 40.px,
      leading: IconButton(
        onPressed: Get.back,
        iconSize: 30.px,
        icon: const Icon(Icons.close, color: Colors.black26),
      ),
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }

  ///构建内容组件内
  Widget buildBody() {
    return Container(
      padding: EdgeInsets.all(15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("修改密码", style: ThemeConfig.normalTextTheme.displayLarge),
          SizedBox(height: 30.px),
          buildOldPassword(),
          SizedBox(height: 15.px),
          buildNewPassword(),
          SizedBox(height: 15.px),
          buildSureNewPassword(),
          SizedBox(height: 25.px),
          buildResetButton(),
          SizedBox(height: 5.px),
          buildQuestionButton()
        ],
      ),
    );
  }

  ///构建账号输入组件
  Widget buildOldPassword() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: GetBuilder<ChangePasswordController>(builder: (logic) {
        return Input(
          placeholder: "请输入原始密码",
          textOffset: 0.05,
          maxLength: 11,
          valueChanged: logic.original,
        );
      }),
    );
  }

  ///构建新密码组件
  Widget buildNewPassword() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: GetBuilder<ChangePasswordController>(builder: (logic) {
        return Input(
          placeholder: "请输入新密码(6~18)",
          textOffset: 0.05,
          valueChanged: logic.target,
        );
      }),
    );
  }

  ///构建确认新密码组件
  Widget buildSureNewPassword() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: buildSureNewPasswordInput(),
    );
  }

  ///构建确认新密码输入组件
  Widget buildSureNewPasswordInput() {
    return GetBuilder<ChangePasswordController>(
      builder: (logic) {
        return Input(
          placeholder: "请输入新密码(长度6~18)",
          textOffset: 0.05,
          obscureText: logic.obscureText,
          suffixIcon: IconButton(
            onPressed: logic.toggle,
            icon: SizedBox(
              width: 20.px,
              height: 20.px,
              child: Image.asset("assets/images/normal/${logic.obscureText ? "eye_off.png" : "eye_on.png"}")
            )
          ),
          valueChanged: logic.confirm,
        );
      });
  }

  ///构建修改按钮组件
  Widget buildResetButton() {
    return Container(
      height: 44.px,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.px)),
      child: ElevatedButton(
        onPressed: controller.isChangeBtnEnable ? controller.changeRequest : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled) ? Colors.black12 : Colors.orangeAccent;
          })
        ),
        child: Text("确认修改",
          style: ThemeConfig.normalTextTheme.displaySmall?.copyWith(color: Colors.white))
      ),
    );
  }

  ///构建遇到问题按钮组件
  Widget buildQuestionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Get.bottomSheet(buildBottomSheet()),
          child: const Text("遇到问题?", style: TextStyle(color: Colors.orangeAccent))
        ),
      ],
    );
  }

  ///构建底部弹窗组件
  Widget buildBottomSheet() {
    List<SheetItem> items = const[
      SheetItem(title: '联系客服', type: SheetItemType.customer),
      SheetItem(title: '我要反馈', type: SheetItemType.feedback),
    ];
    return CustomBottomSheet(
      items: items,
      cancelCallBack: Get.back,
      selectedCallBack: (idx){
        debugPrint("idx === $idx");
        Get.back();
      },
    );
  }
}
