import 'package:flutter/material.dart';
import '../../../tools/extension/int_extension.dart';

class OperationTool extends StatelessWidget {
  const OperationTool(
      {
    Key? key,
    this.color,
    this.height = 40,
    this.iconSize = 40
  }) : super(key: key);

  final Color? color;
  final double? height;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      child: buildUserItemFooter(),
    );
  }

  Widget buildUserItemFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildUserItemFooterItem(icon: "smile.png", title: "82",tag: 0),
        buildUserItemFooterItem(icon: "cry.png", title: "12",tag: 1),
        buildUserItemFooterItem(icon: "message.png", title: "30",tag: 2),
        buildUserItemFooterItem(icon: "share.png", title: "17",tag: 3),
      ],
    );
  }

  Widget buildUserItemFooterItem({String? icon,String? title, int tag = 0}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: (){},
          child: Image.asset("assets/images/footer/$icon", fit: BoxFit.fitHeight,),
        ),
        SizedBox(width: 10.px),
        Text(title ?? "0", style: TextStyle(fontSize: 16.px, color: Colors.black54))
      ],
    );
  }
}
