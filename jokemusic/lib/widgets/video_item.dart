import 'package:flutter/material.dart';

import 'user_item_header.dart';
import 'operation_tool.dart';
import '/tools/extension/int_extension.dart';

enum ItemType {
  ///纯文
  text,
  ///趣图
  picture,
  ///视频
  video
}

class VideoItem extends StatelessWidget {
  VideoItem({
    Key? key,
    EdgeInsets? padding,
    this.actions,
    this.itemType = ItemType.video
  }) : padding = padding ?? EdgeInsets.symmetric(horizontal: 15.px),
        super(key: key);

  final EdgeInsets padding;
  final List<Widget>? actions;
  final ItemType itemType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        children: [
          SizedBox(height: 10.px),
          _itemHeader(),
          SizedBox(height: 10.px),
          _itemText(),
          _itemVideo(),
          _itemFooter()
        ],
      ),
    );
  }

  ///item 头
  Widget _itemHeader() {
    return UserItemHeader(actions: actions);
  }

  ///item 文本
  Widget _itemText() {
    return Text("要不是被这部豆瓣9分的<<隐秘的角落>>刷屏了? 为了做视频,我顺带把原著也通宵读完了!希望这期细致的解说视频大家能喜欢!不注水的良心剧,不该被埋没!",
      style: TextStyle(color: Colors.black87, fontSize: 16.px, letterSpacing: 1.px, height: 1.5),
    );
  }

  ///item 视频
  Widget _itemVideo() {
    if(itemType.index == 1) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset("assets/images/sources/profile_post_tip.png"),
      );
    } else if(itemType.index == 2){
      return Container(
        height: 180.px,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(8.px)
        ),
        margin: EdgeInsets.symmetric(vertical: 10.px),
      );
    }
    return const SizedBox();
  }

  ///item 尾
  Widget _itemFooter() {
    return OperationTool(callBack: (idx) => debugPrint("idx == $idx"));
  }

}
