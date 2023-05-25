import 'package:flutter/material.dart';

import '../../../widgets/navigation_item_bar.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';

///作品视图
class WorksView extends StatefulWidget {
  const WorksView({Key? key}) : super(key: key);

  @override
  State<WorksView> createState() => _WorksViewState();
}

class _WorksViewState extends State<WorksView> {
  int _curIdx = 0;
  final _pageCtrl = PageController();

  void onPageChanged(int idx){
    setState(() {
      _curIdx = idx;
      _pageCtrl.jumpToPage(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHeader(),
        Divider(color: ColorExtension.lineColor,  height: 20.px, thickness: 1.px),
        buildContent()
      ],
    );
  }

  ///构建头部组件
  Widget buildHeader() {
    return NavigationItemBar(
      currentIndex: _curIdx,
      items: const [BarItem(title: "文字图片"), BarItem(title: "视频")],
      crossAxisAlignment: CrossAxisAlignment.start,
      callBack: onPageChanged,
    );
  }

  ///构建内容组件
  Widget buildContent() {
    return PageView(
      controller: _pageCtrl,
      onPageChanged: onPageChanged,
      children: [
        Container(color: Colors.blue),
        Container(color: Colors.orangeAccent)
      ],
    );
  }
}
