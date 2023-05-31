import 'package:flutter/material.dart';
import 'package:jokemusic/tools/extension/int_extension.dart';
import 'package:jokemusic/tools/share/const_config.dart';

import '../../widgets/page_selector.dart';

class VideoPage extends StatefulWidget {
  static const String routeName = "/VideoPage";
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with SingleTickerProviderStateMixin{
  final List<String> _items = ['今日爆款','土货生鲜','会员中心'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('video'), elevation: 0),
      body: PageSelector(
        headerHeight: 58,
        bodyHeight: height,
        isScrollable: false,
        indicator: const BoxDecoration(),
        indicatorWeight: 0,
        headerColor: Colors.green,
        labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
        tabs: List.generate(_items.length, (index) => Tab(child: _tabItems(index))),
        children: List.generate(_items.length, (index) => Center(child: Text(_items[index])))
      ),
    );
  }

  _tabItems(int idx) => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(_items[idx]),
      SizedBox(width: 6.px),
      const Text("1")
    ],
  );
}
