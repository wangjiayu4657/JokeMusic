import 'package:flutter/material.dart';
import 'package:jokemusic/pages/Home/widgets/home_search.dart';
import 'package:jokemusic/pages/message/views/message_item.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/vertical_item.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class MessagePage extends StatefulWidget {
  static const String routeName = "/MessagePage";
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("消息"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, HomeSearch.routeName),
            icon: const Icon(Icons.search)
          )
        ],
        elevation: 0,
        bottom: _header(),
      ),
      body: CustomScrollView(
        slivers: [
          _sliverGrid(),
          SliverToBoxAdapter(
            child: Divider(color: ColorExtension.bgColor, height: 10.px, thickness: 10.px),
          ),
          _sliverList()
        ],
      ),
    );
  }

  PreferredSize _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.px),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.px),
        height: 40.px,
        color: ColorExtension.bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("开启推送通知, 及时查收消息",
              style: TextStyle(fontSize: 12.px, color: Colors.black87)
            ),
            _startButton()
          ],
        ),
      ),
    );
  }

  Widget _startButton() {
    return CustomButton(
      title: "开启",
      width: 58.px,
      height: 26.px,
      radius: 13.px,
      bordColor: Colors.black26,
      enableColor: Colors.white,
      style: TextStyle(fontSize: 12.px, color: Colors.black38),
      onPressed: (){},
    );
  }

  Widget _sliverGrid() {
    return SliverGrid.count(
      crossAxisCount: 3,
      children: [
        buildVerticalItem(title: "赞.踩", imgName: "message_like"),
        buildVerticalItem(title: "评论", imgName: "message_review"),
        buildVerticalItem(title: "关注", imgName: "message_focus"),
      ],
    );
  }

  //构建上下布局的item
  Widget buildVerticalItem({String? title,String? imgName}) {
    return VerticalItem(
      title: title,
      callback: (){},
      margin: 12,
      padding: EdgeInsets.only(top: 5.px),
      icon: Image.asset("assets/images/sources/$imgName.png", fit: BoxFit.contain, width: 54.px)
    );
  }

  Widget _sliverList() {
    return SliverList.separated(
      itemCount: 20,
      itemBuilder: (context, idx) => SizedBox(height: 60.px, child: const MessageItem()),
      separatorBuilder: (context, idx) => Divider(color: ColorExtension.lineColor, height: 10.px, thickness: 1.px)
    );
  }
}
