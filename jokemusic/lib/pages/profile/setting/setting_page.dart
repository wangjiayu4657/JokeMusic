import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'setting_model.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';

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
  var packageInfo = PackageInfo(
      appName: "appName",
      packageName: "packageName",
      version: "version",
      buildNumber: "buildNumber"
  );

  @override
  void initState() {
    super.initState();

    initData();
  }

  ///初始化数据
  void initData() {
    //用户相关
    List<SettingItemModel> userItems = const [
      SettingItemModel(idx: 0,name: "用户信息"),
      SettingItemModel(idx: 1,name: "账号安全"),
    ];
    final userModel = SettingModel(title: "用户相关",list: userItems,section: 0);

    //通用
    List<SettingItemModel> generalItems = const[
      SettingItemModel(idx: 0,name: "推送开关"),
      SettingItemModel(idx: 1,name: "视频自动播放"),
      SettingItemModel(idx: 2,name: "数据网络直接播放视频"),
      SettingItemModel(idx: 3,name: "清楚缓存"),
    ];
    final generalModel = SettingModel(title: "通用",list: generalItems,section: 1);

    //其他设置
    List<SettingItemModel> otherItems = const[
      SettingItemModel(idx: 0,name: "给我评分"),
      SettingItemModel(idx: 1,name: "检查更新"),
      SettingItemModel(idx: 2,name: "用户服务协议"),
      SettingItemModel(idx: 3,name: "隐私政策"),
      SettingItemModel(idx: 4,name: "关于我们"),
    ];
    final otherModel = SettingModel(title: "其他设置", list: otherItems,section: 2);

    //退出登录
    const logoutModel = SettingModel(title: "退出登录",section: 3);

    _list = [userModel,generalModel,otherModel,logoutModel];
  }

  ///初始化packageInfo组件
  void initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => packageInfo = info);
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
           title: Text(model?.list?[idx].name ?? "",style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
           visualDensity: const VisualDensity(vertical: -4),
           trailing: buildListItemBodyTrailing(idx: idx, section: model?.section ?? 0),
         );
       },
       separatorBuilder: (context,idx) => Divider(color: ColorExtension.lineColor, thickness: 1.px),
   );

    // return ListView.builder(
    //   itemCount: model?.list?.length,
    //   shrinkWrap: true,
    //   padding: EdgeInsets.only(bottom: 10.px),
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemBuilder: (context,idx){
    //     return ListTile(
    //       title: Text(model?.list?[idx].name ?? "",style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
    //       visualDensity: const VisualDensity(vertical: -4),
    //       trailing: buildListItemBodyTrailing(idx: idx, section: model?.section ?? 0),
    //     );
    //   }
    // );
  }

  ///构建列表item组件-内容-尾部小组件
  Widget buildListItemBodyTrailing({int idx = 0, int section = 0}) {
    if(section == 1){
      return (idx == 0 || idx == 3) ?
        buildListItemBodyTrailingText(idx == 0 ? "未开启" : "502.80KB") :
        buildListItemBodyTrailingSwitch(idx);
    } else if(section == 2){
      return idx == 1 ? buildListItemBodyTrailingText("v1.0.0") : Icon(Icons.arrow_forward_ios, size: 18.px);
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
