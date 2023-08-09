import 'package:flutter/material.dart';

import 'user_item_header.dart';
import 'operation_tool.dart';
import '/tools/extension/int_extension.dart';

// enum ItemType {
//   ///纯文
//   text,
//   ///趣图
//   picture,
//   ///视频
//   video
// }

class VideoItemView extends StatelessWidget {
  VideoItemView({
    Key? key,
    this.text,
    this.title,
    this.subTitle,
    this.avatar,
    this.imgUrl,
    this.videoUrl,
    this.actions,
    EdgeInsets? padding,
    this.itemType
  }) : padding = padding ?? EdgeInsets.symmetric(horizontal: 15.px),
       super(key: key);

  ///内边距
  final EdgeInsets padding;
  ///操作
  final List<Widget>? actions;
  ///item类型
  final int? itemType;
  ///内容
  final String? text;
  ///主标题
  final String? title;
  ///子标题
  final String? subTitle;
  ///头像
  final String? avatar;
  ///趣图地址
  final String? imgUrl;
  ///视频地址
  final String? videoUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //头部信息
          _itemHeader(),

          //内容文本
          _itemText(),

          //视频/趣图/纯文
          _itemVideo(),

          //尾部操作
          _itemFooter()
      ]),
    );
  }

  ///item 头
  Widget _itemHeader() {
    return UserItemHeader(
      title: title,
      subTitle: subTitle,
      avatar: avatar,
      actions: actions,
      margin: EdgeInsets.only(top: 10.px, bottom: 10.px),
    );
  }

  ///item 文本
  Widget _itemText() {
    return Text(text ?? "",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 16.px,
        letterSpacing: 1.px,
        height: 1.5
      ),
    );
  }

  ///item 视频
  Widget _itemVideo() {
    if(itemType == 1) {                    //纯文
      return const SizedBox();
    } else if(itemType == 2) {             //趣图
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: imgUrl == null
          ? Center(child: Image.asset("assets/images/sources/profile_post_tip.png"))
          : Center(child: Image.network(imgUrl!, fit: BoxFit.fill)),
      );
    } else {                               //视频
      return Container(
        height: 180.px,
        margin: EdgeInsets.symmetric(vertical: 10.px),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(8.px)
        ),
      );
    }
  }

  ///item 尾
  Widget _itemFooter() {
    return OperationTool(
      like: "10",
      unLike: "22",
      comments: "20",
      share: "37",
      callBack: (idx) => debugPrint("idx == $idx")
    );
  }
}
