import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/vertical_item.dart';
import '../../common/user_item_header.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import 'controllers/profile_controller.dart';

///我的
class ProfilePage extends GetView<ProfileController> {
  static const String routeName = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: ColorExtension.lineColor,
      appBar: AppBar(
        elevation: 0,
        title: _buildAppBarTitle(),
        backgroundColor: Colors.transparent ,
      ),
      body: CustomScrollView(
        slivers: [
          //列表头
          _listHeader(children: [
            //头部信息组件(关注,粉丝,乐豆)
            _listHeaderInfoView(),

            //分割线
            Divider(color: ColorExtension.lineColor,height: 12.px),

            //头部用户操作组件(帖子,评论,赞过,搜藏)
            _listHeaderOperationsView(),

            //分割线
            Divider(color: ColorExtension.lineColor,height: 12.px),

            //banner图
            _headerBanner()
          ]),

          //列表内容
          _listView(itemBuilder: (idx) => buildListItem(idx: idx))
        ],
      ),
    );
  }

  ///构建AppBar标题
  Widget _buildAppBarTitle() {
    return Padding(
      padding: EdgeInsets.all(8.px),
      child: GetBuilder<ProfileController>(
        id: "profile_header_info",
        builder: (logic) {
          return UserItemHeader(
            title: logic.userInfo?.nickname,
            subTitle: logic.userInfo?.signature,
            avatar: logic.userInfo?.avatar,
            titleStyle: TextStyle(fontSize: 16.px, color: Colors.black87),
            subTitleStyle: TextStyle(fontSize: 12.px, color: Colors.black87),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: logic.gotoLogin,
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black45),
              )
            ],
          );
        },
      ),
    );
  }

  ///构建内容
  Widget _listView({required Widget Function(int idx) itemBuilder}) {
    return SliverToBoxAdapter(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 15.px, top: 12.px),
        itemCount: controller.titles.length,
        itemBuilder: (ctx,idx) => itemBuilder(idx),
        separatorBuilder: (ctx, idx) {
          if(idx == 0 || idx == 3) return Divider(color: Colors.transparent,thickness: 12.px);
          return Divider(color: Colors.transparent, height: 1.px, thickness: 1.px);
        },
      ),
    );
  }

  //构建列表item组件
  Widget buildListItem({int idx = 0}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: buildBorderRadius(idx)
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      child: ListTile(
        onTap: () => controller.handlerItemClick(tag: idx),
        leading: Image.asset("assets/images/sources/profile_${controller.images[idx]}@3x.png", width: 20.px),
        title: Text(controller.titles[idx], style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
        trailing: Icon(Icons.arrow_forward_ios,size: 18.px),
        visualDensity: const VisualDensity(horizontal: -4),
        minLeadingWidth: 10.px,
      ),
    );
  }

  //处理圆角问题
  BorderRadius buildBorderRadius(int idx) {
    if(idx == 0 || idx == 4) {
      return BorderRadius.circular(8.px);
    } else if(idx == 1){
      return BorderRadius.vertical(top: Radius.circular(8.px));
    } else if(idx == 3){
      return BorderRadius.vertical(bottom: Radius.circular(8.px));
    } else {
      return BorderRadius.zero;
    }
  }

  //构建表头组件
  Widget _listHeader({required List<Widget> children}) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  //构建表头-信息组件
  Widget _listHeaderInfoView() {
    return Container(
      height: 48.px,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal:15.px),
      margin: EdgeInsets.only(top: 34.px, bottom: 5.px),
      child: GetBuilder<ProfileController>(
        id:'profile_user_info',
        builder: (logic){
          return Row(
            children: [
              _infoItem(title: "关注", count: 0),
              SizedBox(width: 45.px),
              _infoItem(title: "粉丝", count: 0),
              SizedBox(width: 45.px),
              _infoItem(title: "乐豆", count: 0),
            ],
          );
        }
      ),
    );
  }

  Widget _infoItem({int? count = 0, required String title}) {
    return VerticalItem(
      icon: Text("$count"),
      title: title,
      width: 40.px
    );
  }

  //构建表头-操作组件
  Widget _listHeaderOperationsView() {
    return Container(
      height: 88.px,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px)
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      padding: EdgeInsets.symmetric(vertical:10.px,horizontal: 20.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildVerticalItem(title: "帖子", imgName: "profile_post"),
          buildVerticalItem(title: "评论", imgName: "profile_comment"),
          buildVerticalItem(title: "赞过", imgName: "profile_like"),
          buildVerticalItem(title: "收藏", imgName: "profile_collect"),
        ],
      ),
    );
  }

  //构建表头-图片组件
  Widget _headerBanner() {
    return Container(
      height: 128.px,
      margin: EdgeInsets.symmetric(horizontal: 15.px,vertical: 5.px),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12.px)
      ),
    );
  }

  //构建上下布局的item
  Widget buildVerticalItem({String? title,String? imgName}) {
    return VerticalItem(
       callback: (){},
       title: title,
       icon: Image.asset("assets/images/sources/$imgName.png", width: 30.px)
    );
  }
}
