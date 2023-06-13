import 'package:flutter/material.dart';
import '../../../tools/extension/int_extension.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(child: Image.asset("assets/images/sources/message_notify.png", width: 40.px)),
          SizedBox(width: 10.px),
          Expanded(child: _itemContent()),
        ],
      ),
    );
  }

  Widget _itemContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _itemTitleAndTime(),
        SizedBox(height: 4.px),
        _itemDesc()
      ],
    );
  }

  ///item 标题和时间
  Widget _itemTitleAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("系统消息", style: TextStyle(fontSize: 16.px, color: Colors.black)),
        Text("06/23 10:48", style: TextStyle(fontSize: 14.px, color: Colors.black26))
      ],
    );
  }

  ///item 内容
  Widget _itemDesc() {
    return const Text("恭喜您注册成功, 希望您在这里能找到快乐...", style: TextStyle(color: Colors.black54));
  }
}
