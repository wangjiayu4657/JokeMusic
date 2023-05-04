import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class AccountSafePage extends StatefulWidget {
  static const String routeName = "/accountSafe";
  const AccountSafePage({Key? key}) : super(key: key);

  @override
  State<AccountSafePage> createState() => _AccountSafePageState();
}

class _AccountSafePageState extends State<AccountSafePage> {

 final  List<String> _list = ["当前绑定手机号","重置密码","修改密码","绑定QQ","绑定新浪微博","注销账号"];

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
        itemCount: _list.length,
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
        onTap: () => debugPrint(_list[idx]),
        title:Text(_list[idx],style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.normal)),
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
