import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/custom_button.dart';
import '../../common/keep_alive_wrapper.dart';
import '../../common/navigation_item_bar.dart';
import '../../common/sliver_header_delegate.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/Profile/user_info_page.dart';
import 'controllers/user_editor_controller.dart';


/*

---------------------------------------------------  page  -----------------------------------------------------
            0                           1                          2                         3
           作品                         喜欢                       评论                       收藏
   ------- subPage -------   ------- subPage -------   ------- subPage -------    ------- subPage -------
     0       1        2         0       1       2        0        1        2         0        1        2
    文字    图片      视频       文字     图片     视频     文字      图片     视频       文字      图片      视频

*/

class UserEditorPage extends GetView<UserEditorController> {
  static const String routeName = "/profile/user_editor";
  const UserEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        headerSliverBuilder: (context, isInnerScroll) => [
          //头部组件
          _sliverHeader(
             onPress: (){} ,
             children: [
               //头部背景图片
               _sliverHeaderImage(),

               //头部内容组件
               _sliverHeaderBody(children: [

                 //头部内容中的用户信息内容
                 _sliverHeaderUserInfoView(children: [

                   //用户信息标题
                   _sliverHeaderBodyContentTitle(),

                   //分割线
                   Divider(color: ColorExtension.lineColor, height: 30.px, thickness: 1.px),

                   //用户签名
                   _sliverHeaderBodyContentSign()
                 ]),

                 //用户头像
                _sliverHeaderBodyIcon(),

                //编辑资料按钮
                _sliverHeaderBodyEditButton(),
             ])
          ]),

          //二级头部组件
          _sliverSubHeader()
        ],
        body: PageView(
          controller: controller.pageCtrl,
          onPageChanged: controller.pageChanged,
          children: List.generate(controller.tabs.length * 3, (index) => _sliverBodyContent(index))
        )
      ),
    );
  }

  ///一级悬停组件
  Widget _sliverHeader({
    required void Function() onPress,
    required List<Widget> children}) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 360.px,
      title: const Text("用户名"),
      titleSpacing: 0,
      centerTitle: false,
      actions: [
        IconButton(onPressed: onPress, icon: const Icon(Icons.more_horiz))
      ],
      flexibleSpace: FlexibleSpaceBar(
        // collapseMode: CollapseMode.pin,
        background: Column(children: children),
      ),
      bottom: _sliverHeaderBottom(),
    );
  }

  ///导航-图片
  Widget _sliverHeaderImage() {
    return SizedBox(
      height: 150.px,
      width: double.infinity,
      child: Image.asset("assets/images/sources/joke_logo.png", fit: BoxFit.fitWidth)
    );
  }

  ///导航-内容
  Widget _sliverHeaderBody({required List<Widget> children}) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: children,
      ),
    );
  }

  ///导航-内容-图标
  Widget _sliverHeaderBodyIcon() {
    return Positioned(
      top: -25.px,
      left: 15.px,
      child: SizedBox(
        width: 80.px,
        height: 80.px,
        child: const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/joke_logo.png")),
      ),
    );
  }

  ///导航-内容-编辑按钮
  Widget _sliverHeaderBodyEditButton() {
    return Positioned(
      top: 8.px,
      right: 15.px,
      child: CustomButton(
        radius: 17.px,
        backgroundColor: Colors.white,
        bordColor: Colors.orangeAccent,
        enableColor: Colors.transparent,
        style: const TextStyle(color: Colors.orangeAccent),
        onPressed: () => Get.toNamed(UserInfoPage.routeName),
        title: "编辑资料"
      ),
    );
  }

  ///导航-内容-内容
  Widget _sliverHeaderUserInfoView({required List<Widget> children}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  ///导航-内容-内容-标题
  Widget _sliverHeaderBodyContentTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 80.px),
      child: Column(
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
      ),
    );
  }

  ///导航--内容-内容-签名描述
  Widget _sliverHeaderBodyContentSign() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("他正在想一个爆炸的签名...", style: TextStyle(fontSize: 14.px, color: Colors.black87)),
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
  Widget _sliverHeaderBodyContentSignItem({int count = 0, String? text}) {
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
            onTap: controller.changeItem,
            controller: controller.tabCtrl,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 15.px),
            dividerColor: ColorExtension.lineColor,
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.orangeAccent,
            labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
            tabs: controller.tabs.map((e) => Tab(text: e)).toList()
          ),
        ),
      ),
    );
  }

  ///二级悬停组件
  Widget _sliverSubHeader() {
    final List<String> tabs = ['文字', '图片', '视频'];
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverHeaderDelegate.fixedHeight(
          height: 58,
          isNeedRebuild: true,
          child: GetBuilder<UserEditorController>(builder: (logic) {
            return NavigationItemBar(
              mainAxisAlignment: MainAxisAlignment.start,
              bottomLineMargin: 0,
              horizontalMargin: 16.px,
              currentIndex: logic.subPage,
              dividerColor: ColorExtension.lineColor,
              padding: EdgeInsets.only(top: 18.px, left: 15.px),
              normalStyle: TextStyle(fontSize: 14.px),
              selectedStyle: TextStyle(fontSize: 14.px, color: Colors.orangeAccent),
              callBack: logic.subItemChanged,
              items: tabs.map((e) => BarItem(title: e)).toList(),
            );
          })
        )
    );
  }

  ///pageView中的内容组件
  Widget _sliverBodyContent(int index) {
    return KeepAliveWrapper(
      child: ListView.builder(
        itemCount: 20,
        padding: EdgeInsets.zero,
        prototypeItem: const ListTile(title: Text(""), subtitle: Text("")),
        itemBuilder: (context, idx) => ListTile(
          title: Text("联系人 $index"),
          subtitle: const Text("电话号码: 136****4657"),
        ),
      ),
    );
  }
}

