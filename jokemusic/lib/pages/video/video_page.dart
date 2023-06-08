import 'package:flutter/material.dart';

import '../../widgets/navigation_item_bar.dart';
import '../../widgets/sliver_header_delegate.dart';
import '../../tools/extension/int_extension.dart';
/*

---------------------------------------  page  ------------------------------------------
            0                             1                               2
         今日爆款                        土货生鲜                         会员中心
--------- subPage -------    ---------- subPage ---------    --------- subPage ---------
   0        1         2         0          1          2        0          1          2
  文字     图片       视频       文字        图片       视频      文字        图片       视频


*/


class VideoPage extends StatefulWidget {
  static const String routeName = "/video_page";
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with SingleTickerProviderStateMixin{
  final List<String> _items = ['今日爆款','土货生鲜','会员中心'];
  int _page = 0;
  int _subPage  = 0;
  final _pageCtrl = PageController();
  late final _tabCtrl = TabController(length: _items.length, vsync: this);

  void _changeItem(int index) {
    _page = index;
    _changeSubItem(0);
  }

  void _changeSubItem(int index){
    _subPage = index;
    _toTargetPage();
  }

  void _pageChanged(int index){
    _page = index ~/ 3;   //_page 取值: 0,1,2
    _subPage = index % 3; //_subPage 取值: 0,1,2
    _toTargetPage();
  }

  void _toTargetPage(){
    int curIdx = _subPage + _page * 3;
    setState(() {
      _pageCtrl.jumpToPage(curIdx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isInnerScroll){
        return [
          _sliverAppBar(),
          _sliverHeader(),
        ];
      },
      body: PageView(
        controller: _pageCtrl,
        onPageChanged: _pageChanged,
        children: List.generate(9, (index) => _sliverBodyContent(index))
      )
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 300.px,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          children: [
             Container(height: 120.px, color: Colors.orange),
             Container(height: 180.px, color: Colors.green)
          ],
        ),
      ),
      bottom: TabBar(
        controller: _tabCtrl,
        onTap: _changeItem,
        tabs: _items.map((e) => Tab(text: e)).toList()
      ),
    );
  }

  Widget _sliverHeader() {
    final List<String> tabs = ['文字','图片','视频' ];
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate.fixedHeight(
        height: 58,
        child: NavigationItemBar(
          mainAxisAlignment: MainAxisAlignment.start,
          horizontalMargin: 16.px,
          padding: EdgeInsets.only(top: 18.px, left: 15.px),
          bottomLineMargin: 0,
          backgroundColor: Colors.cyan,
          normalStyle: TextStyle(fontSize: 14.px),
          selectedStyle: TextStyle(fontSize: 14.px, color: Colors.red),
          callBack: _changeSubItem,
          currentIndex: _subPage,
          items: tabs.map((e) => BarItem(title: e)).toList(),
        )
      )
    );
  }

  Widget _sliverBodyContent(int index) {
    return ListView.builder(
      itemCount: 20,
      padding: EdgeInsets.zero,
      prototypeItem: const ListTile(title: Text(""),subtitle: Text("")),
      itemBuilder: (context,idx) => ListTile(
        title: Text("联系人 $index"),
        subtitle: const Text("电话号码: 136****4657"),
      ),
    );
  }
}

