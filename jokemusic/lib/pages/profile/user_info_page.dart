import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../services/http/http_client.dart';
import '../../tools/share/user_manager.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../tools/extension/object_extension.dart';
import '../../pages/profile/user_info_editor_page.dart';
import '../../pages/profile/views/picker_method.dart';
import '../../pages/login/models/user_info_model.dart';

///我的-设置-用户信息页
class UserInfoPage extends StatefulWidget {
  static const String routeName = "/user_info";
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {

  AssetEntity? _imageFile;
  UserInfoModel? _infoModel;
  List<String> items = const ["头像","昵称","签名","性别","生日","我的邀请码","绑定邀请码"];

  ///处理选择的图片
  Future<void> handlerImageSelected(PickerMethod pickerMethod) async {
    List<AssetEntity> images = <AssetEntity>[];
    final List<AssetEntity>? result = await pickerMethod.method(context, images);
    if (result == null) return;
    _imageFile = result.toList().first;
    if (mounted) setState(() { });
  }

  ///初始化数据模型
  void _initUserInfoModel() async {
    _infoModel = await UserManager.instance.userModel;
    setState(() { });
  }

  void handlerItemSelected({required BuildContext context, int idx = 0}) async {
    switch (idx) {
      case 0:   //头像
        handlerImageSelected(PickerMethod.singleImage());
        updateUserInfoRequest(type: idx, content: "");
        break;
      case 1:   //昵称
        final arguments = {"type":EditType.nickname, "nickname":_infoModel?.nickname};
        final nickname = await Navigator.pushNamed(context, UserInfoEditorPage.routeName,arguments: arguments);
        updateUserInfoRequest(type: idx, content: nickname.toString());
        setState(() => _infoModel?.nickname = nickname.toString());
        break;
      case 2:   //签名
        final arguments = {"type":EditType.nickname, "nickname":_infoModel?.signature};
        final signature = await Navigator.pushNamed(context, UserInfoEditorPage.routeName,arguments: arguments);
        setState(() => _infoModel?.signature = signature.toString());
        updateUserInfoRequest(type: idx, content: signature.toString());
        break;
      case 3:   //性别
        showSexPicker(context, callBack: (sex) {
         setState(() => _infoModel?.sex = sex[1]);
          updateUserInfoRequest(type: idx, content: sex[1]);
        });
        break;
      case 4:   //生日
        showTimePicker(context, callBack: (date){
          final birthday = date.substring(1,10);
          setState(() => _infoModel?.birthday = birthday);
          updateUserInfoRequest(type: idx, content: birthday);
        });
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

  ///更新用户信息: 0 修改头像 先上传到七牛云 1 修改昵称 2 修改签名 3 修改性别 4 修改生日
  void updateUserInfoRequest({int type = 0, String? content}) async {
    const url = "/user/info/update";
    final params = {"content":content, "type":type};
    final result = await HttpClient.request(url: url, params: params);
    final msg = result["msg"].toString();
    final code = mapToInt(result["code"]);
    showToast(msg);
    if(code == 200) {
      if(_infoModel == null) return;
      UserManager.instance.saveUserInfo(_infoModel!);
    }
  }


  @override
  void initState() {
    super.initState();
    _initUserInfoModel();
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: items.length,
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
        onTap: () => handlerItemSelected(context: context, idx: idx),
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
          child: _imageFile == null ?
            _infoModel?.avatar == null ? const SizedBox() : CircleAvatar(child: Image.network(_infoModel?.avatar ?? "")) :
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: AssetEntityImage(_imageFile!, isOriginal: false, fit: BoxFit.fill)
            )
        ),
        Icon(Icons.arrow_forward_ios, size: 18.px, color: Colors.black26),
      ],
    );
  }

  ///性别选择器
  void showSexPicker(BuildContext context,{ValueChanged<String>? callBack}) {
    List<String> data = ["男","女","保密"];
    Picker(
      height: 180.px,
      itemExtent: 44.px,
      changeToFirst: true,
      cancelText: "取消",
      cancelTextStyle: const TextStyle(color: Colors.black45),
      onCancel: (){},
      confirmText: "确定",
      confirmTextStyle: const TextStyle(color: Colors.orangeAccent),
      onConfirm: (picker, result) => callBack?.call(picker.adapter.text),
      adapter: PickerDataAdapter(
        data: data.map((e) => PickerItem<String>(value: e)).toList()
      )
    ).showModal(context);
  }

  ///时间选择器
  void showTimePicker(BuildContext context, {ValueChanged<String>? callBack}) {
    Picker(
      height: 220.px,
      itemExtent: 36.px,
      changeToFirst: true,
      cancelText: "取消",
      cancelTextStyle: const TextStyle(color: Colors.black26),
      onCancel: (){},
      confirmText: "确定",
      confirmTextStyle: const TextStyle(color: Colors.orangeAccent),
      onConfirm: (picker,result) => callBack?.call(picker.adapter.text),
      adapter: DateTimePickerAdapter(
        type: PickerDateTimeType.kYMD,
        isNumberMonth: true,
        yearSuffix: '年',
        monthSuffix: '月',
        daySuffix: '日'
      ),
    ).showModal(context);
  }

}
