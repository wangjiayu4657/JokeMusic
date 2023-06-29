import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:get/get.dart';

import 'controllers/user_info_controller.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';


///我的-设置-用户信息页
class UserInfoPage extends GetView<UserInfoController> {
  static const String routeName = "/user_info";
  const UserInfoPage({Key? key}):super(key:key);

  @override
  String? get tag => "myTag";

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>UserInfoController());
    return Scaffold(
      appBar: AppBar(title: const Text("用户信息")),
      body: buildBody(context),
    );
  }

  ///构建内容组件
  Widget buildBody(BuildContext context) {
    return Container(
      color: ColorExtension.bgColor,
      child: ListView.separated(
        itemCount: controller.items.length,
        itemBuilder: (context,idx) => buildBodyListItem(context:context, idx: idx),
        separatorBuilder: (context,idx) {
          double thickness = idx == 2 || idx == 4 ? 10.px : 1.px;
          return Divider(color: ColorExtension.lineColor, thickness: thickness, height: thickness);
        },
      ),
    );
  }
  
  Widget buildBodyListItem({required BuildContext context, int idx = 0}) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () => controller.handlerItemSelected(context: context, idx: idx),
        title: Text(controller.items[idx], style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
        trailing: buildBodyListItemTrailing(idx),
      ),
    );
  }

  ///构建列表item组件-内容-尾部小组件
  Widget buildBodyListItemTrailing(int idx) {
    if(idx == 0) {
      return buildBodyListItemTrailingImage();
    } else {
      return GetBuilder<UserInfoController>(
        init: controller,
        builder: (_) => buildBodyListItemTrailingText(controller.getText(idx) ?? "")
      );
    }
  }

  ///构建列表item组件-内容-尾部小组件-文本
  Widget buildBodyListItemTrailingText(String text){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text),
        Icon(Icons.arrow_forward_ios, size: 18.px, color:Colors.black26),
      ],
    );
  }

  ///构建列表item组件-内容-尾部小组件-图片
  Widget buildBodyListItemTrailingImage(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 30.px,
          height: 30.px,
          child: controller.imageFile == null ?
          buildAvatar() :
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: AssetEntityImage(controller.imageFile!, isOriginal: false, fit: BoxFit.fill)
          )
        ),
        Icon(Icons.arrow_forward_ios, size: 18.px, color: Colors.black26),
      ],
    );
  }

  Widget buildAvatar() {
    return controller.userModel?.avatar == null ?
           const SizedBox() :
           GetBuilder<UserInfoController>(
             init: controller,
             builder:(_) => CircleAvatar(child: Image.network(controller.userModel?.avatar ?? ""))
           );
  }
}

