import 'package:flutter/material.dart';
import 'package:jokemusic/widgets/keep_alive_wrapper.dart';

import '../../tools/extension/color_extension.dart';
import '../../widgets/custom_button.dart';
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


class UserEditorPage2 extends StatefulWidget {
  static const String routeName = "/user_editor2";
  const UserEditorPage2({Key? key}) : super(key: key);

  @override
  State<UserEditorPage2> createState() => _UserEditorPage2State();
}

class _UserEditorPage2State extends State<UserEditorPage2> with SingleTickerProviderStateMixin {
  int _page = 0;
  int _subPage  = 0;
  final _pageCtrl = PageController();
  final List<String> _tabs = <String>['作品', '喜欢', '评论', '收藏'];
  late final _tabCtrl = TabController(length: _tabs.length, vsync: this);

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
      debugPrint("page == $_page, subPage == $_subPage");
      _pageCtrl.jumpToPage(curIdx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material (
      child: NestedScrollView(
        headerSliverBuilder: (context, isInnerScroll) => [
          _sliverHeader(),
          _sliverSubHeader()
        ],
        body: PageView(
          controller: _pageCtrl,
          onPageChanged: _pageChanged,
          children: List.generate(_tabs.length * 3, (index) => _sliverBodyContent(index))
        )
      ),
    );
  }

  ///一级悬停组件
  Widget _sliverHeader() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 360.px,
      title: const Text("用户名"),
      titleSpacing: 0,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          children: [
            _sliverHeaderImage(),
            Expanded(child: _sliverHeaderBody())
          ],
        ),
      ),
      bottom: _sliverHeaderBottom(),
    );
  }

  ///导航-图片
  Widget _sliverHeaderImage() {
    return SizedBox(
      height: 150.px,
      width: double.infinity,
      child: Image.asset("assets/images/sources/joke_logo.png",fit: BoxFit.fitWidth)
    );
  }

  ///导航-内容
  Widget _sliverHeaderBody() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _sliverHeaderBodyContent(),
        Positioned(
          top: -25.px,
          left: 15.px,
          child: _sliverHeaderBodyIcon()
        ),
        Positioned(
          top: 8.px,
          right: 15.px,
          child: _sliverHeaderBodyEditButton()
        ),
      ],
    );
  }

  ///导航-内容-图标
  Widget _sliverHeaderBodyIcon() {
    return SizedBox(
      width: 80.px,
      height: 80.px,
      child: const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/joke_logo.png")),
    );
  }

  ///导航-内容-编辑按钮
  Widget _sliverHeaderBodyEditButton() {
    return CustomButton(
      radius: 17.px,
      backgroundColor: Colors.white,
      textColor: Colors.orangeAccent,
      enableColor: Colors.transparent,
      onPressed: (){},
      title: "编辑资料"
    );
  }

  ///导航-内容-内容
  Widget _sliverHeaderBodyContent() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80.px),
          _sliverHeaderBodyContentTitle(),
          Divider(color: ColorExtension.lineColor, height: 30.px, thickness: 1.px),
          _sliverHeaderBodyContentSign()
        ],
      ),
    );
  }

  ///导航-内容-内容-标题
  Widget _sliverHeaderBodyContentTitle(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("乐-D7",
          style: TextStyle(
            fontSize: 18.px,
            color: Colors.black87,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 6.px),
        Text("入住段子乐: 1个月",
          style: TextStyle(
            fontSize: 12.px,
            color: Colors.black54,
            fontWeight: FontWeight.normal
          ),
        )
      ],
    );
  }

  ///导航--内容-内容-签名描述
  Widget _sliverHeaderBodyContentSign(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("他正在想一个爆炸的签名...",style: TextStyle(fontSize: 14.px, color: Colors.black87)),
        SizedBox(height: 15.px),
        Row(
          children: [
            _sliverHeaderBodyContentSignItem(count: 0, text: "获赞"),
            SizedBox(width: 18.px),
            _sliverHeaderBodyContentSignItem(count: 0, text: "关注"),
            SizedBox(width: 18.px),
            _sliverHeaderBodyContentSignItem(count: 0, text: "粉丝"),
          ],
        )
      ],
    );
  }

  ///导航-内容-内容-签名-操作item
  Widget _sliverHeaderBodyContentSignItem({int count=0, String? text}) {
    return Row(
      children: [
        Text("$count",
          style: TextStyle(
            fontSize: 18.px,
            color: Colors.black87,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(width: 6.px),
        Text(text ?? "",
          style: TextStyle(
            fontSize: 16.px,
            color: Colors.black87,
            fontWeight: FontWeight.normal
          )
        ),
      ],
    );
  }

  ///导航-底部组件
  PreferredSizeWidget _sliverHeaderBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(54.px),
      child: Material(
        color: Colors.white,
        child: Theme(
          data: ThemeData(useMaterial3: true, splashFactory: NoSplash.splashFactory),
          child: TabBar(
            onTap: _changeItem,
            controller: _tabCtrl,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding:EdgeInsets.symmetric(horizontal: 15.px),
            dividerColor: ColorExtension.lineColor,
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.orangeAccent,
            labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
            tabs: _tabs.map((e) => Tab(text: e)).toList()
          ),
        ),
      ),
    );
  }

  ///二级悬停组件
  Widget _sliverSubHeader() {
    final List<String> tabs = ['文字','图片','视频'];
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate.fixedHeight(
        height: 58,
        isNeedRebuild: true,
        child: NavigationItemBar(
          mainAxisAlignment: MainAxisAlignment.start,
          horizontalMargin: 16.px,
          padding: EdgeInsets.only(top: 18.px, left: 15.px),
          bottomLineMargin: 0,
          normalStyle: TextStyle(fontSize: 14.px),
          selectedStyle: TextStyle(fontSize: 14.px, color: Colors.red),
          currentIndex: _subPage,
          callBack: _changeSubItem,
          items: tabs.map((e) => BarItem(title: e)).toList(),
        )
      )
    );
  }

  ///pageView中的内容组件
  Widget _sliverBodyContent(int index) {
    return KeepAliveWrapper(
      child: ListView.builder(
        itemCount: 20,
        padding: EdgeInsets.zero,
        prototypeItem: const ListTile(title: Text(""),subtitle: Text("")),
        itemBuilder: (context,idx) => ListTile(
          title: Text("联系人 $index"),
          subtitle: const Text("电话号码: 136****4657"),
        ),
      ),
    );
  }
}
