import 'package:flutter/material.dart';

import '../tools/extension/int_extension.dart';

///登录/重置密码/修改密码/底部的用户须知组件
class UserNotice extends StatefulWidget {
  const UserNotice({Key? key}) : super(key: key);

  @override
  State<UserNotice> createState() => _UserNoticeState();
}

class _UserNoticeState extends State<UserNotice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.px,
      padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 15.px),
      color: Colors.white,
      child: buildNoticeWidget(),
    );
  }

  ///构建登录方式组件 - 底部说明组件
  Widget buildNoticeWidget() {
    TextStyle style1 = const TextStyle(color: Colors.black54);
    TextStyle style2 = const TextStyle(color: Colors.orangeAccent);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.px,
      runSpacing: 2.px,
      children: [
        Text("登录/注册代表您同意段子乐", style: style1),
        InkWell(
          onTap: (){ debugPrint("《隐私政策》"); },
          child: Text("《隐私政策》", style: style2)
        ),
        Text("和", style: style1),
        InkWell(
          onTap: (){ debugPrint("《用户服务协议》"); },
          child: Text("《用户服务协议》", style: style2)
        )
      ],
    );
  }
}
