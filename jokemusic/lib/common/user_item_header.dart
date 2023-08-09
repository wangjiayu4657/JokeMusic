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
    this.margin,
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
  final EdgeInsets? margin;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final GestureTapCallback? onTap;

  final LoginController loginViewModel = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return _buildUserItemHeader(children: [

      _itemLeading(),

      _itemContent(),

      _itemTrailing(),
    ]);
  }

  Widget _buildUserItemHeader({required List<Widget> children}) {
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  ///构建图标组件
  Widget _itemLeading() {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: avatar == null || avatar?.isEmpty == true
        ? const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/avatar.png"))
        : ClipOval(
          child: FadeInImage.assetNetwork(
            image: avatar!,
            placeholder: "assets/images/sources/avatar.png",
            fit: BoxFit.cover,
          ),
        )
    );
  }

  ///构建信息组件
  Widget _itemContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title ?? "丛林中的仙子",style: titleStyle),
            SizedBox(height: 4.px),
            Text(subTitle ?? "不是我不笑, 一笑粉就掉!",
              maxLines: 1,
              style: subTitleStyle,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  ///构建右侧组件
  Widget _itemTrailing() {
    return (actions == null || actions?.isEmpty == true)
      ? const SizedBox()
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: actions!
        );
  }
}

