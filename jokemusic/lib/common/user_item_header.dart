import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../tools/extension/int_extension.dart';
import '../pages/login/login_controller.dart';

///用户信息头部组件
class UserItemHeader extends StatelessWidget {
  UserItemHeader({
    Key? key,
    this.height = 60,
    this.iconSize = 48,
    this.backgroundColor,
    this.actions,
    this.title,
    this.subTitle,
    this.avatar,
    this.padding,
    this.titleStyle,
    this.subTitleStyle,
    this.onTap,
  }) : super(key: key);

  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final String? title;
  final String? subTitle;
  final String? avatar;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final GestureTapCallback? onTap;

  final LoginController loginViewModel = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      color: backgroundColor,
      child: buildUserItemHeader(),
    );
  }

  ///构建用户信息头组件
  Widget buildUserItemHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        buildUserItemHeaderIconAndInfo(),
        buildUserItemHeaderMore()
      ],
    );
  }

  ///构建图标和信息组件
  Widget buildUserItemHeaderIconAndInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildUserItemHeaderIcon(),
        SizedBox(width: 10.px),
        buildUserItemHeaderInfo()
      ],
    );
  }

  ///构建图标组件
  Widget buildUserItemHeaderIcon() {
    return SizedBox(
        width: iconSize,
        height: iconSize,
        child: avatar == null ?
         const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/avatar.png")) :
         FadeInImage.assetNetwork(
           image: avatar!,
           placeholder: "assets/images/sources/avatar.png",
           fit: BoxFit.cover,
         )
    );
  }

  ///构建信息组件
  Widget buildUserItemHeaderInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Obx(() => Text(loginViewModel.nickname, style: titleStyle)),
        Text(title ?? "丛林中的仙子",style: titleStyle),
        SizedBox(height: 4.px),
        Text(subTitle ?? "不是我不笑, 一笑粉就掉!",style: subTitleStyle)
        // Obx(() => Text(subTitle ?? loginViewModel.signature, style: subTitleStyle)),
      ],
    );
  }

  ///构建右侧组件
  Widget buildUserItemHeaderMore() {
    return (actions == null || actions?.isEmpty == true) ?
      const SizedBox() :
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions!
      );
  }
}

