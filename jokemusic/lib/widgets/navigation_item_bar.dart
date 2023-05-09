import 'package:flutter/material.dart';

import '../tools/extension/int_extension.dart';
import '../tools/extension/string_extension.dart';

///自定义导航项目栏
class NavigationItemBar extends StatefulWidget {
  NavigationItemBar({
    Key? key,
    required this.items,
    this.currentIndex,
    this.isShowBottomLine = false,
    this.bottomLineWidth,
    Color? bottomLineColor,
    TextStyle? normalStyle,
    TextStyle? selectedStyle,
    this.callBack,
  }) : bottomLineColor = bottomLineColor ?? Colors.redAccent,
       normalStyle = normalStyle ??
           TextStyle(color: Colors.black87, fontSize: 18.px, fontWeight: FontWeight.normal),
       selectedStyle = selectedStyle ??
           TextStyle(color: Colors.redAccent, fontSize: 20.px, fontWeight: FontWeight.bold),
       super(key: key);

  final List<String> items;
  final int? currentIndex;
  final bool? isShowBottomLine;
  final Color? bottomLineColor;
  final double? bottomLineWidth;
  final TextStyle? normalStyle;
  final TextStyle? selectedStyle;
  final ValueChanged<int>? callBack;

  @override
  State<NavigationItemBar> createState() => _NavigationItemBarState();
}

class _NavigationItemBarState extends State<NavigationItemBar> {
  late int _index = 0;
  late List<String> items = widget.items ?? [];

  @override
  Widget build(BuildContext context) {
    _index = widget.currentIndex ?? 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (idx) {
          return navigationBarItem(title: items[idx],tag: idx);
        }).toList(),
      ),
    );
  }

  Widget navigationBarItem({String? title, int tag = 0}) {
    final state = _index == tag;
    final style = state ? widget.selectedStyle : widget.normalStyle;
    final width = StringExtension.calculateWidth(context: context, text: title ?? "", style: style);
    final color = (state && widget.isShowBottomLine == true) ? widget.bottomLineColor : Colors.transparent;

    return Expanded(
      child: InkWell(
        onTap: () {
          widget.callBack?.call(tag);
          setState(() => _index = tag);
        },
        child: Column(
          children: [
            Text(title ?? "", style: style),
            SizedBox(
              width: widget.bottomLineWidth ?? width,
              child: Divider(color: color, thickness: 2.px, height: 10.px)
            )
          ],
        ),
      ),
    );
  }
}
