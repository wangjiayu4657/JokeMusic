import 'package:flutter/material.dart';

import '../tools/extension/int_extension.dart';
import '../tools/extension/string_extension.dart';

class BarItem {
  const BarItem({
    this.title,
    this.count
  });

  final String? title;
  final int? count;
}

///自定义导航项目栏
class NavigationItemBar extends StatefulWidget {
  NavigationItemBar({
    Key? key,
    required this.items,
    this.currentIndex,
    this.isShowBottomLine = false,
    this.isAutoRashin = false,
    this.bottomLineWidth,
    this.bottomLineMargin = 0,
    Color? bottomLineColor,
    TextStyle? normalStyle,
    TextStyle? selectedStyle,
    this.countStyle,
    CrossAxisAlignment? crossAxisAlignment,
    EdgeInsets? padding,
    this.callBack,
  }) : bottomLineColor = bottomLineColor ?? Colors.redAccent,
       normalStyle = normalStyle ??
           TextStyle(color: Colors.black87, fontSize: 18.px, fontWeight: FontWeight.normal),
       selectedStyle = selectedStyle ??
           TextStyle(color: Colors.redAccent, fontSize: 20.px, fontWeight: FontWeight.bold),
       crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center,
       padding = padding ?? EdgeInsets.symmetric(vertical: 15.px),
       super(key: key);

  ///item数据
  final List<BarItem> items;
  ///当前索引
  final int? currentIndex;
  ///是否展示底部滑动线
  final bool? isShowBottomLine;
  ///底部滑动线是否自适应, 如果设置了宽度则该属性无效
  final bool? isAutoRashin;
  ///底部滑动线的颜色
  final Color? bottomLineColor;
  ///底部滑动线的宽度
  final double? bottomLineWidth;
  ///底部滑动线距离文本的间距
  final double? bottomLineMargin;
  ///未选中时item的样式
  final TextStyle? normalStyle;
  ///选中后item的样式
  final TextStyle? selectedStyle;
  ///数量文本的样式, 如果没有设置则跟随item文本颜色
  final TextStyle? countStyle;
  ///item的对齐方式
  final CrossAxisAlignment? crossAxisAlignment;
  ///内边距
  final EdgeInsets? padding;
  ///回调
  final ValueChanged<int>? callBack;

  @override
  State<NavigationItemBar> createState() => _NavigationItemBarState();
}

class _NavigationItemBarState extends State<NavigationItemBar> {
  late int _index = 0;
  late List<BarItem> items = widget.items;

  @override
  Widget build(BuildContext context) {
    _index = widget.currentIndex ?? 0;
    return Container(
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (idx) {
          return navigationBarItem(item: items[idx],tag: idx);
        }).toList(),
      ),
    );
  }

  Widget navigationBarItem({BarItem? item, int tag = 0}) {
    final state = _index == tag;
    final style = state ? widget.selectedStyle : widget.normalStyle;
    final color = (state && widget.isShowBottomLine == true) ? widget.bottomLineColor : Colors.transparent;
    double width = StringExtension.calculateWidth(context: context, text: item?.title ?? "", style: style);
    width += item?.count == null ? 0 : 12.px;

    return Expanded(
      child: InkWell(
        onTap: () {
          widget.callBack?.call(tag);
          setState(() => _index = tag);
        },
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            buildCountText(item: item, style: style),
            SizedBox(height: widget.bottomLineMargin),
            SizedBox(
              width: widget.bottomLineWidth ?? (widget.isAutoRashin == true ? double.infinity : width),
              child: Divider(color: color, thickness: 2.px, height: 10.px)
            )
          ],
        ),
      ),
    );
  }

  Widget buildCountText({BarItem? item, TextStyle? style}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(item?.title ?? "", style: style),
        SizedBox(width: 6.px),
        if(item?.count != null) Text("${item?.count ?? 0}", style: widget.countStyle ?? style?.copyWith(fontSize: 16.px))
      ],
    );
  }
}
