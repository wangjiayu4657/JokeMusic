import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'user_info_page.dart';
import 'models/setting_model.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = "/setting";
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  List<SettingModel> _list = [];   //数据源
  bool _autoPlay = false;          //视频自动播放
  bool _dataPlay = false;          //使用数据网络直接播放视频
  var _packageInfo = PackageInfo(
    appName: "Unknown",
    packageName: "Unknown",
    version: "Unknown",
    buildNumber: "Unknown",
    buildSignature: "Unknown",
    installerStore: "Unknown"
  );

  @override
  void initState() {
    super.initState();

    _initData();
    _initPackageInfo();
  }

  ///初始化数据
  void _initData() {
    //用户相关
    const users = ["用户信息", "账号安全"];
    final userModel = SettingModel.initModel(section: 0, title: "用户相关", names: users);

    //通用
    const generals = ["推送开关","视频自动播放","数据网络直接播放视频","清除缓存"];
    final generalModel = SettingModel.initModel(section: 1, title: "通用", names: generals);

    //其他设置
    const others = ["给我评分","检查更新","用户服务协议","隐私政策","关于我们"];
    final otherModel = SettingModel.initModel(section: 2, title: "其他设置", names: others);

    //退出登录
    final logoutModel = SettingModel(section: 3, title: "退出登录");

    _list = [userModel,generalModel,otherModel,logoutModel];
  }

  ///初始化packageInfo组件
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  ///处理列表item的点击事件
  void handlerItemSelected({int section = 0, int row = 0}){
    switch (section){
      case 0:
        if(row == 0) {                    //用户信息
          Navigator.pushNamed(context, UserInfoPage.routeName);
        } else {                          //账号安全

        }
        break;
      case 1:
        if(row == 0){                     //推送开关

        } else if(row == 3){              //清除缓存

        }
        break;
      case 2:
        if(row == 0){                     //给我评分

        } else if(row == 1){              //检查更新

        } else if(row == 2){              //用户服务协议

        } else if(row == 3) {             //隐私政策

        } else {                          //关于我们

        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    RouterConfig;
    return Scaffold(
      appBar: AppBar(title: const Text("设置")),
      body: buildBody(),
    );
  }

  ///构建内容组件
  Widget buildBody() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context,idx){
        return idx == 3 ? buildListViewFooter() : buildListItem(idx);
      }
    );
  }

  ///构建列表item组件
  Widget buildListItem(int idx) {
    return Column(
      children: [
        buildListItemHeader(idx),
        Divider(color: ColorExtension.lineColor,thickness: 1.px),
        buildListItemBody(model:_list[idx]),
        buildListItemFooter()
      ],
    );
  }

  ///构建列表item组件-头部
  Widget buildListItemHeader(int idx) {
    return Container(
      height: 44.px,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.px,right: 15.px,top: 8.px),
      child: Text(_list[idx].title ?? "",style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.bold)),
    );
  }

  ///构建列表item组件-内容
  Widget buildListItemBody({SettingModel? model}) {
   return ListView.separated(
       shrinkWrap: true,
       padding: EdgeInsets.only(bottom: 18.px),
       physics: const NeverScrollableScrollPhysics(),
       itemCount: model?.list?.length ?? 0,
       itemBuilder: (context,idx){
         return ListTile(
           onTap: () => handlerItemSelected(section:model?.section ?? 0, row: idx),
           title: Text(model?.list?[idx].name ?? "",style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
           visualDensity: const VisualDensity(vertical: -4),
           trailing: buildListItemBodyTrailing(idx: idx, section: model?.section ?? 0),
         );
       },
       separatorBuilder: (context,idx) => Divider(color: ColorExtension.lineColor, thickness: 1.px),
   );
  }

  ///构建列表item组件-内容-尾部小组件
  Widget buildListItemBodyTrailing({int idx = 0, int section = 0}) {
    if(section == 1){
      return (idx == 0 || idx == 3) ?
        buildListItemBodyTrailingText(idx == 0 ? "未开启" : "502.80KB") :
        buildListItemBodyTrailingSwitch(idx);
    } else if(section == 2){
      return idx == 1 ? buildListItemBodyTrailingText(_packageInfo.version) : Icon(Icons.arrow_forward_ios, size: 18.px);
    }
    return Icon(Icons.arrow_forward_ios, size: 18.px);
  }

  ///构建列表item组件-内容-尾部小组件-文本
  Widget buildListItemBodyTrailingText(String text){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text),
        Icon(Icons.arrow_forward_ios, size: 18.px),
      ],
    );
  }

  ///构建列表item组件-内容-尾部小组件-开关
  Widget buildListItemBodyTrailingSwitch(int idx) {
    return CupertinoSwitch(
      value: idx == 1 ? _autoPlay : _dataPlay,
      onChanged: (val) => setState(() {
        idx == 1 ? _autoPlay = val : _dataPlay = val;
      })
    );
  }

  ///构建列表item组件-尾部
  Widget buildListItemFooter() {
    return Divider(color: ColorExtension.bgColor,thickness: 10.px,height: 0.01);
  }

  ///构建列表尾部组件
  Widget buildListViewFooter() {
    return Container(
      height: 48.px,
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 25.px),
      child: Text("退出登录", style: TextStyle(color: Colors.orangeAccent,fontSize: 16.px)),
    );
  }
}
