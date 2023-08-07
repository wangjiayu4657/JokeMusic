import 'package:flutter/material.dart';
import '../../../tools/extension/int_extension.dart';

class OperationTool extends StatelessWidget {
  const OperationTool({
    Key? key,
    this.like,
    this.unLike,
    this.comments,
    this.share,
    this.color,
    this.height = 40,
    this.iconSize = 40,
    this.callBack
  }) : super(key: key);

  ///喜欢
  final String? like;
  ///不喜欢
  final String? unLike;
  ///评论
  final String? comments;
  ///分享
  final String? share;
  ///背景颜色
  final Color? color;
  ///高度
  final double? height;
  ///图标尺寸
  final double? iconSize;
  ///回调
  final ValueChanged? callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      child: buildUserItemFooter(),
    );
  }

  Widget buildUserItemFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildUserItemFooterItem(icon: "smile.png", title: like,tag: 0),
        buildUserItemFooterItem(icon: "cry.png", title: unLike,tag: 1),
        buildUserItemFooterItem(icon: "message.png", title: comments,tag: 2),
        buildUserItemFooterItem(icon: "share.png", title: share,tag: 3),
      ],
    );
  }

  Widget buildUserItemFooterItem({String? icon,String? title, int tag = 0}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => callBack?.call(tag),
          child: SizedBox(
            width: 24.px,
            height: 24.px,
            child: Image.asset("assets/images/footer/$icon", fit: BoxFit.contain)
          ),
        ),
        SizedBox(width: 10.px),
        Text(title ?? "0", style: TextStyle(fontSize: 16.px, color: Colors.black54))
      ],
    );
  }
}
