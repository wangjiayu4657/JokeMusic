import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/login/models/user_info_model.dart';

class UserInfoPage extends StatefulWidget {
  static const String routeName = "/userInfo";
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {

  UserInfoModel? _infoModel;
  List<String> items = ["头像","昵称","签名","性别","生日","我的邀请码","绑定邀请码"];

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  void _initModel() {
   _infoModel = UserInfoModel(
      avatar: "assets/images/sources/joke_logo.png",
      nickname: "xiaowang",
      signature: "this is a test content",
      sex: "保密",
      birthday: "1999.06.07",
      inviteCode: "4657",
      invitedCode: "4657"
    );
  }

  void handlerItemSelected(int idx) {
    switch (idx) {
      case 0:   //头像
        ImagePicker().pickImage(source: ImageSource.gallery);
        break;
      case 1:   //昵称
        break;
      case 2:   //签名
        break;
      case 3:   //性别
        showModalBottomSheet(context: context, builder: (context) => buildSexBottomSheet());
        break;
      case 4:   //生日
        break;
      case 5:   //我的邀请码
        break;
      case 6:   //绑定邀请码
        break;
      default:
        break;
    }
  }

  ///获取对应item的文案
  String? getText(int idx){
    if(idx == 1){
      return _infoModel?.nickname;
    } else if(idx == 2) {
      return _infoModel?.signature;
    } else if(idx == 3) {
      return _infoModel?.sex;
    } else if(idx == 4){
      return _infoModel?.birthday;
    } else if(idx == 5){
      return _infoModel?.inviteCode;
    } else if(idx == 6){
      return _infoModel?.invitedCode;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("用户信息")),
      body: buildBody(),
    );
  }

  ///构建内容组件
  Widget buildBody() {
    return Container(
      color: ColorExtension.bgColor,
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context,idx) => buildBodyListItem(idx: idx),
        separatorBuilder: (context,idx){
          double thickness = idx == 2 || idx == 4 ? 10.px : 1.px;
          return Divider(color: ColorExtension.lineColor,thickness: thickness,height: 0.01);
        },
      ),
    );
  }
  
  Widget buildBodyListItem({int idx = 0}) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () => handlerItemSelected(idx),
        title: Text(items[idx], style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
        trailing: buildBodyListItemTrailing(idx),
      ),
    );
  }

  ///构建列表item组件-内容-尾部小组件
  Widget buildBodyListItemTrailing(int idx) {
    if(idx == 0) {
      return buildBodyListItemTrailingImage();
    } else {
      final text = getText(idx) ?? "";
      return buildBodyListItemTrailingText(text);
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
          child: CircleAvatar(child: Image.asset(_infoModel?.avatar ?? "")),
        ),
        Icon(Icons.arrow_forward_ios, size: 18.px, color: Colors.black26),
      ],
    );
  }

  ///构建底部性别选择窗组件
  Widget buildSexBottomSheet() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSexBottomSheetHeader(),
          buildSexBottomSheetBody()
        ],
      ),
    );
  }

  ///构建底部性别选择窗组件-头部组件
  Widget buildSexBottomSheetHeader() {
    return Container(
      height: 44.px,
      color: ColorExtension.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => setState(() =>  Navigator.pop(context)),
            child: const Text("取消",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600))
          ),
          TextButton(
            onPressed: () => setState(() => Navigator.pop(context)),
            child: const Text("确定",style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w600))
          ),
        ],
      ),
    );
  }

  ///构建底部性别选择窗组件-内容组件
  Widget buildSexBottomSheetBody() {
    List<String> sexes = ["男","女","保密"];
    return SizedBox(
      height: 180.px,
      child: CupertinoPicker(
        itemExtent: 48.px,
        backgroundColor: Colors.white,
        onSelectedItemChanged: (idx) => _infoModel?.sex = sexes[idx],
        children: sexes.map((e) => Center(child: Text(e))).toList()
      ),
    );
  }
}
