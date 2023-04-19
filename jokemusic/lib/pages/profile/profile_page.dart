import 'package:flutter/material.dart';

import '../../widgets/vertical_item.dart';
import '../../widgets/user_item_header.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = "/ProfilePage";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<String> titles = ["我的客服","审核中","审核失败","分享给朋友","意见反馈","赏个好评","设置"];
  List<String> images = ["customer","auditing","audit_failure","share","feedback","praise","setting"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildAppBarTitle(),
        elevation: 0,
        backgroundColor: ColorExtension.lineColor,
      ),
      body: buildBody(),
    );
  }

  //构建AppBar标题
  Widget buildAppBarTitle() {
    return Padding(
      padding: EdgeInsets.all(8.px),
      child: UserItemHeader(
        title: "登录/注册",
        subTitle: "快来开始你的创作吧~",
        titleStyle: TextStyle(fontSize: 16.px, color: Colors.black87),
        subTitleStyle: TextStyle(fontSize: 12.px, color: Colors.black87),
        backgroundColor: Colors.transparent,
        right: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.black45),
        ),
      ),
    );
  }


  //构建内容
  Widget buildBody() {
    return Container(
      color: ColorExtension.lineColor,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: titles.length + 1,
        itemBuilder: (ctx,idx) {
          if(idx == 0) return buildListHeader();
          return buildListItem(idx: idx - 1);
        },
        separatorBuilder: (ctx, idx) {
          if(idx == 1 || idx == 3) return Divider(color: Colors.transparent,thickness: 12.px);
          return const Divider(color: Colors.transparent, height: 0.01,);
        },
      ),
    );
  }

  //构建列表item组件
  Widget buildListItem({int idx = 0}) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Image.asset("assets/images/sources/profile_${images[idx]}@3x.png", width: 20.px),
        title: Text(titles[idx], style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
        trailing: Icon(Icons.arrow_forward_ios,size: 18.px),
        visualDensity: const VisualDensity(horizontal: -4),
        minLeadingWidth: 10.px,
      ),
    );
  }

  Widget buildListHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24.px),
        buildListHeaderInfo(),
        Divider(color: ColorExtension.lineColor,height: 12.px),
        buildListHeaderOperations(),
        Divider(color: ColorExtension.lineColor,height: 12.px),
        buildListHeaderIcon()
      ],
    );
  }

  Widget buildListHeaderInfo() {
    return Container(
      height: 48.px,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal:15.px),
      child: Row(
        children: [
          const VerticalItem(icon: Text("-"), title: "关注"),
          SizedBox(width: 45.px),
          const VerticalItem(icon: Text("-"), title: "粉丝"),
          SizedBox(width: 45.px),
          const VerticalItem(icon: Text("-"), title: "乐豆"),
        ],
      ),
    );
  }

  Widget buildListHeaderOperations() {
    return Container(
      height: 88.px,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px)
      ),
      padding: EdgeInsets.all(10.px),
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildVerticalItem(title: "帖子", imgName: "profile_post"),
          buildVerticalItem(title: "评论", imgName: "profile_comment"),
          buildVerticalItem(title: "赞过", imgName: "profile_like"),
          buildVerticalItem(title: "收藏", imgName: "profile_collect"),
        ],
      ),
    );
  }

  //构建
  Widget buildListHeaderIcon() {
    return SizedBox(
      height: 128.px,
      child: Container(
        margin: EdgeInsets.only(left:15.px,bottom: 12.px,right: 15.px),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12.px)
        ),
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
