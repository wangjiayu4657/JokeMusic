import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/input.dart';
import '../../common/user_notice.dart';
import '../../common/code_button.dart';
import '../../common/custom_bottom_sheet.dart';
import '../../services/theme/theme_config.dart';
import '../../services/http/http.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../tools/extension/object_extension.dart';
import '../profile/controllers/reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  static const String routeName = "/profile/setting/account_safe/reset_password";
  const ResetPasswordPage({Key? key}) : super(key: key);

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
          Text("重置密码", style: ThemeConfig.normalTextTheme.displayLarge),
          SizedBox(height: 30.px),
          buildAccount(),
          SizedBox(height: 15.px),
          buildCode(),
          SizedBox(height: 15.px),
          buildNewPassword(),
          SizedBox(height: 25.px),
          buildResetButton(),
          SizedBox(height: 5.px),
          buildQuestionButton()
        ],
      ),
    );
  }

  ///构建账号输入组件
  Widget buildAccount() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: Input(
        placeholder: "请输入手机号码",
        textOffset: 0.05,
        maxLength: 11,
        valueChanged: controller.inputPhoneNum,
      ),
    );
  }

  ///构建验证码组件
  Widget buildCode() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: buildCodeInput()),
          buildCodeButton()
        ],
      ),
    );
  }

  ///构建验证码输入组件
  Widget buildCodeInput() {
    return Input(
      placeholder: "请输入验证码",
      textOffset: 0.05,
      valueChanged: controller.inputCode,
    );
  }

  ///构建验证码按钮组件
  Widget buildCodeButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 2.px,
          height: 15.px,
          color: Colors.black12,
        ),
        SizedBox(
          width: 130.px,
          child: GetBuilder<ResetPasswordController>(builder: (logic) {
            return CodeButton(
              second: 5,
              phone: logic.phone,
              style: TextStyle(fontSize: 15.px, color: Colors.black26),
              callback: logic.codeBtnClick
            );
          })
        )
      ],
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
      child: buildNewPasswordInput(),
    );
  }

  ///构建新密码输入组件
  Widget buildNewPasswordInput() {
    return GetBuilder<ResetPasswordController>(builder: (logic){
        return Input(
          placeholder: "请输入新密码(长度6~18)",
          textOffset: 0.05,
          obscureText: logic.obscureText,
          suffixIcon: IconButton(
            onPressed: logic.reverseObscureText,
            icon: SizedBox(
              width: 20.px,
              height: 20.px,
              child: Image.asset("assets/images/normal/${logic.obscureText ? "eye_off.png" : "eye_on.png"}")
            )
          ),
          valueChanged: logic.inputPassword,
        );
      },
    );
  }

  ///构建登录按钮组件
  Widget buildResetButton() {
    return Container(
      height: 44.px,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.px)),
      child: ElevatedButton(
        onPressed: controller.resetBtnClick,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled) ? Colors.black12 : Colors.orangeAccent;
          })
        ),
        child: Text("重  置", style: ThemeConfig.normalTextTheme.displaySmall?.copyWith(color: Colors.white))
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
    return CustomBottomSheet(items: items);
  }
}
