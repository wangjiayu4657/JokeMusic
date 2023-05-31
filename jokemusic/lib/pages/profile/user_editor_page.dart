import 'package:flutter/material.dart';

// import 'views/work_view.dart';
import '../../widgets/page_selector.dart';
import '../../widgets/custom_button.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../widgets/navigation_item_bar.dart';

class UserEditorPage extends StatefulWidget {
  static const String routeName = "/user_editor";
  const UserEditorPage({Key? key}) : super(key: key);

  @override
  State<UserEditorPage> createState() => _UserEditorPageState();
}

class _UserEditorPageState extends State<UserEditorPage> {
  int _curIdx = 0;
  final _pageCtrl = PageController();
  final List<BarItem> _items = const [
    BarItem(title: "作品", count: 1),
    BarItem(title: "喜欢", count: 1),
    BarItem(title: "评论", count: 1),
    BarItem(title: "收藏", count: 1),
  ];

  void onPageChanged(int idx){
    setState(() {
      _curIdx = idx;
      _pageCtrl.jumpToPage(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  ///构建内容组件
  Widget buildBody() {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(),
        buildSliverBody()
      ],
    );
  }

  ///构建内容组件-导航
  Widget buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      // floating: true,
      expandedHeight: 320.px,
      actions: [
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_horiz)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            buildFlexibleSpaceBarImg(),
            Expanded(child: buildFlexibleSpaceBarBody())
          ],
        ),
      ),
    );
  }

  ///构建内容组件-导航-背景图片
  Widget buildFlexibleSpaceBarImg() {
    return SizedBox(
      height: 150.px,
      width: double.infinity,
      child: Image.asset("assets/images/sources/joke_logo.png",fit: BoxFit.fitWidth)
    );
  }

  ///构建内容组件-导航-内容
  Widget buildFlexibleSpaceBarBody() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildFlexibleSpaceBarBodyContent(),
        Positioned(
          top: -25.px,
          left: 15.px,
          child: buildFlexibleSpaceBarBodyIcon()
        ),
        Positioned(
          top: 8.px,
          right: 15.px,
          child: buildFlexibleSpaceBarBodyEditButton()
        ),
      ],
    );
  }

  ///构建内容组件-导航-内容-图标
  Widget buildFlexibleSpaceBarBodyIcon() {
    return SizedBox(
      width: 80.px,
      height: 80.px,
      child: const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/joke_logo.png")),
    );
  }

  ///构建内容组件-导航-内容-编辑按钮
  Widget buildFlexibleSpaceBarBodyEditButton() {
    return CustomButton(
      radius: 17.px,
      backgroundColor: Colors.white,
      textColor: Colors.orangeAccent,
      enableColor: Colors.transparent,
      onPressed: (){},
      title: "编辑资料"
    );
  }

  ///构建内容组件-导航-内容-内容
  Widget buildFlexibleSpaceBarBodyContent() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80.px),
          buildFlexibleSpaceBarBodyContentTitle(),
          Divider(color: ColorExtension.lineColor,height: 30.px, thickness: 1.px),
          buildFlexibleSpaceBarBodyContentSign()
        ],
      ),
    );
  }

  ///构建内容组件-导航-内容-标题
  Widget buildFlexibleSpaceBarBodyContentTitle(){
    return Column(
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
            fontSize: 14.px,
            color: Colors.black54,
            fontWeight: FontWeight.normal
          ),
        )
      ],
    );
  }

  ///构建内容组件-导航-内容-前面
  Widget buildFlexibleSpaceBarBodyContentSign(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("他正在想一个爆炸的签名...",style: TextStyle(fontSize: 16.px, color: Colors.black87)),
        SizedBox(height: 15.px),
        Row(
          children: [
            buildFlexibleSpaceBarBodyContentSignItem(count: 0, text: "获赞"),
            SizedBox(width: 18.px),
            buildFlexibleSpaceBarBodyContentSignItem(count: 0, text: "关注"),
            SizedBox(width: 18.px),
            buildFlexibleSpaceBarBodyContentSignItem(count: 0, text: "粉丝"),
          ],
        )
      ],
    );
  }

  ///构建内容组件-导航-内容-签名-操作item
  Widget buildFlexibleSpaceBarBodyContentSignItem({int count=0,String? text}) {
    return Row(
      children: [
        Text("$count",style: TextStyle(fontSize: 18.px, color: Colors.black87, fontWeight: FontWeight.bold)),
        SizedBox(width: 6.px),
        Text(text ?? "",style: TextStyle(fontSize: 16.px, color: Colors.black87, fontWeight: FontWeight.normal)),
      ],
    );
 }

 
 
  Widget buildSliverBody() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context,idx) => buildSliverBodyContent(),
        childCount: 1,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      )
    );
  }

  _tabItems(int idx) => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(_items[idx].title),
      SizedBox(width: 6.px),
      Text("${_items[idx].count}")
    ],
  );

  Widget buildSliverBodyContent() {
    return PageSelector(
      bodyHeight: height,
      headerHeight: 30.px,
      tabs: List<Widget>.generate(_items.length, (index) => _tabItems(index)),
      children: List<Widget>.generate(_items.length, (index) => Center(child: Text(_items[index].title))),
    );
  }

  Widget buildSliverBodyContentHeader() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        buildSliverBodyContentItemBar(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 4.px,
          child: const Divider(color: ColorExtension.lineColor, height: 1, thickness: 1)
        )
      ],
    );
  }

  Widget buildSliverBodyContentItemBar({int count=0,String? text}) {
    return NavigationItemBar(
      items: _items,
      currentIndex: _curIdx,
      bottomLineMargin: 2.px,
      padding: EdgeInsets.only(left: 15.px, top: 12.px),
      isShowBottomLine: true,
      bottomLineColor: Colors.redAccent,
      crossAxisAlignment: CrossAxisAlignment.start,
      callBack: onPageChanged
    );
  }

  Widget buildSliverBodyContentPageView() {
    return PageView(
      controller: _pageCtrl,
      onPageChanged: onPageChanged,
      children: [
        // WorksView(),
        // WorksView(),
        Container(width: 175, height: 680, color: Colors.green),
        Container(width: 175, height: 680, color: Colors.orangeAccent),
      ],
    );
  }





}
