import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/setting_model.dart';
import 'controllers/setting_controller.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

///我的-设置页
class SettingPage extends GetView<SettingController> {
  static const String routeName = "/profile/setting";
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterConfig;
    return Scaffold(
      appBar: AppBar(title: const Text("设置")),
      body: CustomScrollView(slivers: [
          //列表
          _listView(itemBuilder: (idx) => _listItem(idx)),

          //退出登录视图
          SliverSafeArea(sliver: _logoutView())
        ],
      ),
    );
  }

  ///列表
  Widget _listView({required Widget Function(int idx) itemBuilder}) {
    return SliverList.builder(
      itemCount: controller.list.length,
      itemBuilder: (context, idx) => itemBuilder(idx)
    );
  }

  ///构建列表item组件
  Widget _listItem(int idx) {
    return Column(
      children: [
        //组头
        _listItemHeader(idx),

        //分割线
        Divider(color: ColorExtension.lineColor, thickness: 1.px),

        //内容
        _listItemBody(model: controller.list[idx]),

        //组尾
        _listItemFooter()
      ],
    );
  }

  ///构建列表item组件-头部
  Widget _listItemHeader(int idx) {
    return Container(
      height: 44.px,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.px, right: 15.px, top: 8.px),
      child: Text(controller.list[idx].title ?? "",
          style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold)),
    );
  }

  ///构建列表item组件-内容
  Widget _listItemBody({SettingModel? model}) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 18.px),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model?.list?.length ?? 0,
      itemBuilder: (context, idx) {
        return ListTile(
          onTap: () => controller.handlerItemSelected(section: model?.section ?? 0, row: idx),
          title: Text(model?.list?[idx].name ?? "",
              style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
          visualDensity: const VisualDensity(vertical: -4),
          trailing: _listItemBodyTrailing(idx: idx, section: model?.section ?? 0),
        );
      },
      separatorBuilder: (context, idx) => Divider(color: ColorExtension.lineColor, thickness: 1.px),
    );
  }

  ///构建列表item组件-内容-尾部小组件
  Widget _listItemBodyTrailing({int idx = 0, int section = 0}) {
    if (section == 1) {
      return (idx == 0 || idx == 3)
        ? _listItemBodyTrailingText(idx == 0 ? "未开启" : "502.80KB")
        : _listItemBodyTrailingSwitch(idx);
    } else if (section == 2) {
      return idx == 1
        ? GetBuilder<SettingController>(builder: (logic){
          return _listItemBodyTrailingText(logic.packageInfo.version);
        })
        : Icon(Icons.arrow_forward_ios, size: 18.px);
    }
    return Icon(Icons.arrow_forward_ios, size: 18.px);
  }

  ///构建列表item组件-内容-尾部小组件-文本
  Widget _listItemBodyTrailingText(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text),
        Icon(Icons.arrow_forward_ios, size: 18.px),
      ],
    );
  }

  ///构建列表item组件-内容-尾部小组件-开关
  Widget _listItemBodyTrailingSwitch(int idx) {
    return GetBuilder<SettingController>(builder: (logic) {
      return CupertinoSwitch(
        value: idx == 1 ? logic.autoPlay : logic.dataPlay,
        onChanged: (val) => logic.changeValue(idx: idx, val: val)
      );
    });
  }

  ///构建列表item组件-尾部
  Widget _listItemFooter() {
    return Divider(color: ColorExtension.bgColor, thickness: 10.px, height: 0.01);
  }

  ///构建列表尾部组件
  Widget _logoutView() {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: controller.logoutRequest,
        child: Container(
          height: 48.px,
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25.px),
          child: Text("退出登录", style: TextStyle(color: Colors.orangeAccent, fontSize: 16.px)),
        ),
      ),
    );
  }
}
