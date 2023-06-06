import 'package:flutter/material.dart';

import '../../tools/share/const_config.dart';
import '../../tools/extension/color_extension.dart';
import '../../tools/extension/int_extension.dart';
import '../../widgets/custom_button.dart';
import '../../pages/profile/views/work_view.dart';

class UserEditorPage2 extends StatefulWidget {
  static const String routeName = "/user_editor2";
  const UserEditorPage2({Key? key}) : super(key: key);

  @override
  State<UserEditorPage2> createState() => _UserEditorPage2State();
}

class _UserEditorPage2State extends State<UserEditorPage2> {
  final List<String> tabs = <String>['作品', '喜欢', '评论', '收藏'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _headerSliver(context,innerBoxIsScrolled),
          ],
          body: _bodySliver(context)
        ),
      ),
    );
  }

  ///导航
  Widget _headerSliver(BuildContext context,bool innerBoxIsScrolled) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        pinned: true,
        // floating: true,
        // snap: false,
        expandedHeight: 360.px,
        elevation: 0,
        forceElevated: innerBoxIsScrolled,
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz))],
        title: const Text("用户"),
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerSliverImg(),
              Expanded(child: _headerSliverBody())
            ],
          ),
        ),
        // toolbarHeight: 60,
        bottom: _tabBar()
      ),
    );
  }


  PreferredSizeWidget _tabBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.px),
      child: Material(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(useMaterial3: true),
          child: TabBar(
            dividerColor: ColorExtension.lineColor,
            tabs: tabs.map((e) => Tab(text: e)).toList()
          ),
        ),
      ),
    );
  }

  ///导航-图片
  Widget _headerSliverImg({double? height}) {
    return SizedBox(
      height: height ?? 150.px,
      width: double.infinity,
      child: Image.asset("assets/images/sources/joke_logo.png",fit: BoxFit.fitWidth)
    );
  }

  ///导航-内容
  Widget _headerSliverBody() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _sliverHeaderBodyContent(),
        Positioned(
          top: -25.px,
          left: 15.px,
          child: _headerSliverBodyIcon()
        ),
        Positioned(
          top: 8.px,
          right: 15.px,
          child: _headerSliverBodyEditButton()
        ),
      ],
    );
  }

  ///导航-内容-图标
  Widget _headerSliverBodyIcon() {
    return SizedBox(
      width: 80.px,
      height: 80.px,
      child: const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/joke_logo.png")),
    );
  }

  ///导航-内容-编辑按钮
  Widget _headerSliverBodyEditButton() {
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
          _headerSliverBodyContentTitle(),
          Divider(color: ColorExtension.lineColor,height: 30.px, thickness: 1.px),
          _headerSliverBodyContentSign()
        ],
      ),
    );
  }

  ///导航-内容-内容-标题
  Widget _headerSliverBodyContentTitle(){
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
  Widget _headerSliverBodyContentSign(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("他正在想一个爆炸的签名...",style: TextStyle(fontSize: 14.px, color: Colors.black87)),
        SizedBox(height: 15.px),
        Row(
          children: [
            _headerSliverBodyContentSignItem(count: 0, text: "获赞"),
            SizedBox(width: 18.px),
            _headerSliverBodyContentSignItem(count: 0, text: "关注"),
            SizedBox(width: 18.px),
            _headerSliverBodyContentSignItem(count: 0, text: "粉丝"),
          ],
        )
      ],
    );
  }

  ///导航-内容-内容-签名-操作item
  Widget _headerSliverBodyContentSignItem({int count=0,String? text}) {
    return Row(
      children: [
        Text("$count",style: TextStyle(fontSize: 18.px, color: Colors.black87, fontWeight: FontWeight.bold)),
        SizedBox(width: 6.px),
        Text(text ?? "",style: TextStyle(fontSize: 16.px, color: Colors.black87, fontWeight: FontWeight.normal)),
      ],
    );
  }


  Widget _bodySliver(BuildContext context) {
    return TabBarView(
      children: tabs.map((e) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(builder: (context) => _bodySliverContent(context,e))
        );
      }).toList(),
    );
  }

  ///主体内容
  Widget _bodySliverContent(BuildContext context,String name) {
    return CustomScrollView(
      key: PageStorageKey<String>(name),
      slivers: <Widget>[
        SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),

        // const SliverFillRemaining(
        //   child: WorkView(),
        // ),

        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.px),
          sliver: SliverFixedExtentList(
            itemExtent: height * 3,
            delegate: SliverChildBuilderDelegate((context,idx) => const WorkView(),
              childCount: 1
            )
          ),
        ),
      ],
    );
  }
}

