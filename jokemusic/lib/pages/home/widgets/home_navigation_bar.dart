import 'package:flutter/material.dart';

import '../../../tools/extension/int_extension.dart';

class HomeNavigationBar extends StatefulWidget {

  const HomeNavigationBar({
    Key? key,
    this.callBack,
    this.currentIndex
  }) : super(key: key);

  final int? currentIndex;
  final ValueChanged<int>? callBack;

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  late int _index = 0;

  @override
  Widget build(BuildContext context) {
    _index = widget.currentIndex ?? 0;
    return Container(
      height: 88.px,
      padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navigationBarItem(title: "关注",tag: 0),
          navigationBarItem(title: "推荐",tag: 1),
          navigationBarItem(title: "新鲜",tag: 2),
          navigationBarItem(title: "纯文",tag: 3),
          navigationBarItem(title: "趣图",tag: 4),
          navigationBarItemSearch(),
        ],
      ),
    );
  }

  Widget navigationBarItem({String? title, int tag = 0}) {
    bool state = _index == tag;
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.callBack?.call(tag);
          setState(() => _index = tag);
        },
        child: Text(title ?? "",
          style: TextStyle(
            fontSize: state ? 20.px : 18.px,
            color: state ? Colors.deepOrangeAccent : Colors.black87,
            fontWeight: state ? FontWeight.bold : FontWeight.normal
          )
        ),
      ),
    );
  }

  Widget navigationBarItemSearch() {
    return InkWell(
        onTap: () {
          widget.callBack?.call(5);
          setState(() => _index = 5);
        },
        child: Container(
          width: 48.px,
          height: 48.px,
          padding: EdgeInsets.only(left: 32.px),
          child: Icon(
            Icons.search,
            color: _index == 5 ? Colors.deepOrangeAccent : Colors.black87
          ),
        )
    );
  }
}

