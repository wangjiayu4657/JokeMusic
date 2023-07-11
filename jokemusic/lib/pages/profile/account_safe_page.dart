import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/account_safe_controller.dart';

import '../../common/input.dart';
import '../../common/custom_button.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

///我的-设置-账号与安全页
class AccountSafePage extends GetView<AccountSafeController> {
  static const String routeName = "/profile/setting/account_safe";
  const AccountSafePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("账号与安全")),
      body: buildBody(),
    );
  }

  ///构建内容组件
  Widget buildBody() {
    return Container(
      color: ColorExtension.bgColor,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 10.px),
        itemCount: controller.list.length,
        itemBuilder: (context,idx) => buildListItem(idx),
        separatorBuilder: (context,idx) {
          double thickness = (idx == 0 || idx == 2 || idx == 5) ? 10.px : 1.px;
          return Divider(color: Colors.transparent, height: thickness);
        }
      ),
    );
  }

  ///构建内容-列表-item组件
  Widget buildListItem(int idx) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () => controller.handlerItemSelected(idx),
        title: Text(controller.list[idx], style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
        trailing: buildListItemTrailing(idx)
      ),
    );
  }

  ///构建内容-列表-item-尾部组件
  Widget buildListItemTrailing(int idx) {
    if(idx == 0) {
      return const Text("136****9052");
    } else if(idx == 3) {
      return buildListItemBodyTrailingText(text: "未绑定");
    } else if(idx == 4){
      return buildListItemBodyTrailingText(text: "未绑定");
    } else if(idx == 5){
      return buildListItemBodyTrailingText(text: "注销后无法恢复,请谨慎操作",color: Colors.orangeAccent);
    } else {
      return Icon(Icons.arrow_forward_ios,size: 18.px, color: Colors.black26);
    }
  }

  ///构建内容-列表-item-尾部-文本组件
  Widget buildListItemBodyTrailingText({String? text, Color? color}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text ?? "", style: TextStyle(color: color)),
        Icon(Icons.arrow_forward_ios, size: 18.px ,color: Colors.black26),
      ],
    );
  }
}

///注销弹窗
class CancelOutAlertView extends StatelessWidget {
  const CancelOutAlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAlert(children: [
      //头
      _alertHeader(),

      //分割线
      Divider(color: ColorExtension.lineColor, height: 1.px),

      //内容
      _alertContent(),

      //输入框
      _alertInput(),

      //注销按钮
      _alertCancellationButton()
    ]);
  }

  ///构建弹窗组件
  Widget _buildAlert({required List<Widget> children}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Get.back();
        Get.focusScope?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: (){},
          child: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 15.px),
              margin: EdgeInsets.symmetric(horizontal: 20.px),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.px))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///构建弹窗-头部组件
  Widget _alertHeader() {
    return Container(
      height: 64.px,
      padding: EdgeInsets.symmetric(horizontal: 20.px),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text("注销账户", style: TextStyle(color: Colors.black87, fontSize: 18.px))
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: Get.back, icon: const Icon(Icons.close))
          )
        ],
      ),
    );
  }

  ///构建弹窗-内容组件
  Widget _alertContent() {
    return Padding(
      padding: EdgeInsets.only(top: 15.px, left: 20.px, bottom: 15.px, right: 20.px),
      child: Text("警告: 账户一旦被注销, 将无法在使用此账号进行登录与注册, 且此账号下的所有数据将会变成僵尸数据, 无法找回, 您只能使用新的账号进行注册使用! 请谨慎操作~",
        style: TextStyle(color: Colors.redAccent, fontSize: 14.px),
      ),
    );
  }

  ///构建弹窗-输入组件
  Widget _alertInput() {
    return Container(
      height: 44.px,
      margin: EdgeInsets.only(left: 20.px, bottom: 5.px, right: 20.px),
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(24.px)
      ),
      child: Input(
        placeholder: "请输入当前账号的密码",
        textOffset: 0.1,
        valueChanged: (text){ },
      ),
    );
  }

  ///构建弹窗-注销按钮组件
  Widget _alertCancellationButton() {
    return Container(
      height: 64.px,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.px,horizontal: 20.px),
      child: CustomButton(
        onPressed: (){ debugPrint('注销'); },
        title: "考虑好了, 注销~", disableColor: Colors.orangeAccent
      )
    );
  }
}
