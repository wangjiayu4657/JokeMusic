import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/login/login_page.dart';
import '../../pages/login/viewModels/login_view_model.dart';
import '../../pages/profile/viewModels/profile_view_model.dart';
import '../../widgets/vertical_item.dart';
import '../../widgets/user_item_header.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

///我的
class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile_page";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const List<String> _titles = ["我的客服","审核结果","分享给朋友","意见反馈","设置"];
  static const List<String> _images = ["customer","auditing","share","feedback","setting"];
  final ProfileViewModel _profileViewModel = ProfileViewModel();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: true,
      create: (context) => ProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: buildAppBarTitle(),
          backgroundColor: ColorExtension.lineColor,
        ),
        body: buildBody(),
      ),
    );
  }

  //构建AppBar标题
  Widget buildAppBarTitle() {
    return Padding(
      padding: EdgeInsets.all(8.px),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return UserItemHeader(
            title: viewModel.isLogin ? "登录/注册" : viewModel.userInfoModel?.nickname,
            subTitle: "快来开始你的创作吧~",
            avatar: viewModel.userInfoModel?.avatar,
            titleStyle: TextStyle(fontSize: 16.px, color: Colors.black87),
            subTitleStyle: TextStyle(fontSize: 12.px, color: Colors.black87),
            backgroundColor: Colors.transparent,
            right: IconButton(
              onPressed: () => _profileViewModel.gotoLogin(context),
              icon: child ?? const Icon(Icons.arrow_forward_ios, color: Colors.black45),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward_ios, color: Colors.black45),
      ),
    );
  }

  //构建内容
  Widget buildBody() {
    return Container(
      color: ColorExtension.lineColor,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 15.px),
        itemCount: _titles.length + 1,
        itemBuilder: (ctx,idx) {
          return idx == 0 ? buildListHeader() : buildListItem(idx: idx - 1);
        },
        separatorBuilder: (ctx, idx) {
          if(idx == 1 || idx == 4) return Divider(color: Colors.transparent,thickness: 12.px);
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
        onTap: () => _profileViewModel.handlerItemClick(context: context, tag: idx),
        leading: Image.asset("assets/images/sources/profile_${_images[idx]}@3x.png", width: 20.px),
        title: Text(_titles[idx], style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
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

  //构建表头-信息组件
  Widget buildListHeaderInfo() {
    return Container(
      height: 48.px,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal:15.px),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child){
          return  Row(
            children: [
              VerticalItem(icon: Text("${viewModel.socialInfo?.attentionNum ?? 0 }"), title: "关注", width: 40.px),
              SizedBox(width: 45.px),
              VerticalItem(icon: Text("${viewModel.socialInfo?.fansNum ?? 0 }"), title: "粉丝", width: 40.px),
              SizedBox(width: 45.px),
              VerticalItem(icon: Text("${viewModel.socialInfo?.experienceNum ?? 0 }"), title: "乐豆", width: 40.px),
            ],
          );
        },
      ),
    );
  }

  //构建表头-操作组件
  Widget buildListHeaderOperations() {
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
