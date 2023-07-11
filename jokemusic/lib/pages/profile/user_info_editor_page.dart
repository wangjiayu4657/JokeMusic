import 'package:flutter/material.dart';

import '../../common/input.dart';
import '../../common/custom_button.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

enum EditType {
  ///昵称
  nickname,
  ///签名
  signature
}

///用户信息编辑页
class UserInfoEditorPage extends StatefulWidget {
  static const String routeName = "/profile/user_info/user_info_editor";

  const UserInfoEditorPage({
    Key? key,
    this.arguments
  }) : super(key: key);

  final Map<String,dynamic>? arguments;

  @override
  State<UserInfoEditorPage> createState() => _UserInfoEditorPageState();
}

class _UserInfoEditorPageState extends State<UserInfoEditorPage> {
  late final editType = widget.arguments?["type"];
  late final String? nickname = widget.arguments?["nickname"];
  late final String? signature = widget.arguments?["signature"];

  String get title => editType == EditType.nickname ?"修改昵称" : "修改签名";
  String get placeholder => editType == EditType.nickname ? nickname ?? "请输入昵称" : signature ?? "请输入签名";

  String? _desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: ColorExtension.bgColor,
        child: Column(
          children: [
            _inputView(),
            SizedBox(height: 15.px),
            _saveButton()
          ],
        ),
      ),
    );
  }

  Widget _inputView() {
    return Container(
      height: 120.px,
      margin: EdgeInsets.only(top: 15.px),
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px)
      ),
      child: Input(
        maxLines: null,
        placeholder: placeholder,
        valueChanged: (text) => _desc = text
      )
    );
  }

  ///保存按钮
  Widget _saveButton() {
    return CustomButton(
      title: "保存",
      height: 44.px,
      width: width - 30.px,
      radius: 8.px,
      style: const TextStyle(color: Colors.white),
      backgroundColor: Colors.orangeAccent,
      onPressed: () => Navigator.pop(context, _desc),
    );
  }
}
