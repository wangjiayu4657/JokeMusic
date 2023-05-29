import 'package:flutter/material.dart';
import 'package:jokemusic/tools/extension/int_extension.dart';

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
    return PageSelector(
      appBarHeight: 58,
      indicator: const BoxDecoration(),
      indicatorWeight: 0,
      labelStyle: TextStyle(fontSize: 16.px),
      tabs: List.generate(_items.length, (index) => Tab(child: _tabItems(index))).toList(),
      children: List.generate(_items.length, (index) => Center(child: Text(_items[index]))).toList()
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
