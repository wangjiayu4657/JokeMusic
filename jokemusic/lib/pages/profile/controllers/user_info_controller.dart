import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../views/picker_method.dart';
import '../user_info_editor_page.dart';
import '../../login/login_model.dart';
import '../../../tools/share/user_manager.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/object_extension.dart';
import '../../../services/http/http_client.dart';

class UserInfoController extends GetxController {
  AssetEntity? imageFile;
  UserInfoModel? userModel;
  List<String> items = const ["头像","昵称","签名","性别","生日","我的邀请码","绑定邀请码"];

  @override
  void onInit() {
    _initUserInfoModel();
    super.onInit();
  }

  // static UserInfoController get to => Get.find();

  void test()  {

  }

  ///处理选择的图片
  Future<void> handlerImageSelected(PickerMethod pickerMethod) async {
    List<AssetEntity> images = <AssetEntity>[];
    final List<AssetEntity>? result = await pickerMethod.method(Get.context!, images);
    if (result == null) return;
    imageFile = result.toList().first;
    update();
  }

  ///初始化数据模型
  void _initUserInfoModel() async {
    userModel = await UserManager.instance.userModel;
    update();
  }

  void handlerItemSelected({int idx = 0}) async {
    switch (idx) {
      case 0:   //头像
        handlerImageSelected(PickerMethod.singleImage());
        updateUserInfoRequest(type: idx, content: "");
        break;
      case 1:   //昵称
        final arguments = {"type":EditType.nickname, "nickname":userModel?.nickname};
        final nickname = await Get.toNamed(UserInfoEditorPage.routeName,arguments: arguments);
        userModel?.nickname = nickname.toString();

        if(nickname == null) return;
        updateUserInfoRequest(type: idx, content: nickname.toString());
        break;
      case 2:   //签名
        final arguments = {"type":EditType.nickname, "nickname":userModel?.signature};
        final signature = await Get.toNamed(UserInfoEditorPage.routeName,arguments: arguments);
        userModel?.signature = signature.toString();

        if(signature == null) return;
        updateUserInfoRequest(type: idx, content: signature.toString());
        break;
      case 3:   //性别
        showSexPicker(callBack: (sex) {
          userModel?.sex = sex[1];
          updateUserInfoRequest(type: idx, content: sex[1]);
        });
        break;
      case 4:   //生日
        showTimePicker(callBack: (date){
          final birthday = date.substring(0,10);
          userModel?.birthday = birthday;
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
      return userModel?.nickname;
    } else if(idx == 2) {
      return userModel?.signature;
    } else if(idx == 3) {
      return userModel?.sex;
    } else if(idx == 4){
      return userModel?.birthday;
    } else if(idx == 5){
      return userModel?.inviteCode;
    } else if(idx == 6){
      return userModel?.invitedCode;
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
    if(code == 200 && userModel != null) {
      UserManager.instance.saveUserInfo(userModel!);
    }

    update();
  }

  ///性别选择器
  void showSexPicker({ValueChanged<String>? callBack}) {
    if(Get.context == null) return;
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
    ).showModal(Get.context!);
  }

  ///时间选择器
  void showTimePicker({ValueChanged<String>? callBack}) {
    if(Get.context == null) return;
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
    ).showModal(Get.context!);
  }
}