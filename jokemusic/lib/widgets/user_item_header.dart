import 'package:flutter/material.dart';
import '../tools/extension/int_extension.dart';

///用户信息头部组件
class UserItemHeader extends StatelessWidget {
  const UserItemHeader({
    Key? key,
    this.height = 60,
    this.iconSize = 48,
    this.backgroundColor,
    this.right,
    this.title,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.onTap,
  }) : super(key: key);

  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Widget? right;
  final String? title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
        child: const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/avatar.png"))
    );
  }

  ///构建信息组件
  Widget buildUserItemHeaderInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? "丛林中的仙子",style: titleStyle),
        SizedBox(height: 4.px),
        Text(subTitle ?? "不是我不笑, 一笑粉就掉!",style: subTitleStyle)
      ],
    );
  }

  ///构建右侧组件
  Widget buildUserItemHeaderMore() {
    return SizedBox(
      width: 30.px,
      child: right ?? IconButton(
         onPressed: onTap,
         icon: const Icon(Icons.more_horiz)
      ),
    );
  }
}

