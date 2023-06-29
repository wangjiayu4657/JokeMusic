import 'package:flutter/material.dart';

import '../../../common/page_selector.dart';
import '../../../common/navigation_item_bar.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';

///作品视图
class WorkView extends StatefulWidget {
  const WorkView({
    Key? key
  }) : super(key: key);

  @override
  State<WorkView> createState() => _WorkViewState();
}

class _WorkViewState extends State<WorkView> {
  final List<BarItem> _tabs = const [BarItem(title: "文字图片"), BarItem(title: "视频")];

  @override
  Widget build(BuildContext context) {
    return PageSelector(
      indicatorWeight: 0,
      indicator: const BoxDecoration(),
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.only(top: 4.px, left: 15.px),
      dividerColor: ColorExtension.lineColor,
      tabs: List<Widget>.generate(_tabs.length, (index) => _tabItem(index)),
      children: List<Widget>.generate(_tabs.length, (index) => _tabView(index))
    );
  }

  Widget _tabItem(int index) {
    return Tab(
      child: Text(_tabs[index].title, style: const TextStyle(color: Colors.black54))
    );
  }
  
  Widget _tabView(int index) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 50,
      prototypeItem: const ListTile(),
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, idx) {
        return const ListTile(
          leading: Icon(Icons.people),
          title: Text("联系人"),
          subtitle: Text("电话号码: 186****4657"),
          trailing: Icon(Icons.delete),
        );
      }
    );
  }
}
