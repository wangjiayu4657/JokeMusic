import 'package:flutter/material.dart';

import '../../../widgets/page_selector.dart';
import '../../../widgets/navigation_item_bar.dart';
import '../../../tools/extension/color_extension.dart';

///作品视图
class WorkView extends StatefulWidget {
  const WorkView({
    Key? key
  }) : super(key: key);

  @override
  State<WorkView> createState() => _WorkViewState();
}

class _WorkViewState extends State<WorkView> with SingleTickerProviderStateMixin {
  int _curIdx = 0;
  final _pageCtrl = PageController();
  final List<BarItem> _tabs = const [BarItem(title: "文字图片"), BarItem(title: "视频")];
  late final _tabCtrl = TabController(length: _tabs.length, vsync: this);

  void onPageChanged(int idx){
    setState(() {
      _curIdx = idx;
      _pageCtrl.jumpToPage(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _pageSelector();
  }

  Widget _pageSelector() {
    return PageSelector(
      indicator: const BoxDecoration(),
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
