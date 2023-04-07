import 'package:flutter/material.dart';
import '../tools/extension/int_extension.dart';

class UserItemHeader extends StatelessWidget {
  const UserItemHeader({
    Key? key,
    this.height = 60,
    this.iconSize = 48,
    this.color,
    this.right,
    this.onTap,
  }) : super(key: key);

  final double? height;
  final double? iconSize;
  final Color? color;
  final Widget? right;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      child: buildUserItemHeader(),
    );
  }

  //构建用户信息头组件
  Widget buildUserItemHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children:  [
        buildUserItemHeaderIconAndInfo(),
        buildUserItemHeaderMore()
      ],
    );
  }

  //构建图标和信息组件
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

  //构建图标组件
  Widget buildUserItemHeaderIcon() {
    return Padding(
      padding: EdgeInsets.only(left: 15.px),
      child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: const CircleAvatar(backgroundImage: AssetImage("assets/images/placeholder.png"))
      ),
    );
  }

  //构建信息组件
  Widget buildUserItemHeaderInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("丛林中的仙子",style: TextStyle(fontSize: 14.px)),
        SizedBox(height: 4.px),
        Text("不是我不笑, 一笑粉就掉!",style: TextStyle(fontSize: 12.px))
      ],
    );
  }

  //构建更多(...)组件
  Widget buildUserItemHeaderMore() {
    return SizedBox(
      width: 60.px,
      child: right ?? IconButton(
         onPressed: onTap,
         icon: const Icon(Icons.more_horiz)
      ),
    );
  }
}

