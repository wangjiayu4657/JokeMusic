import 'package:flutter/material.dart';

import '../../../tools/extension/int_extension.dart';

///没有数据时的提示视图
class NoDataPrompt extends StatelessWidget {
  const NoDataPrompt({
    Key? key,
    this.placeholderText = "暂无数据",
    this.placeholderImage = "assets/images/sources/profile_post_tip.png"
  }) : super(key: key);

  ///占位提示文本
  final String placeholderText;
  ///占位提示图片
  final String placeholderImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 160.px,
          height: 160.px,
          child: Image.asset(placeholderImage),
        ),
        Text(placeholderText, style: TextStyle(fontSize: 16.px,color: Colors.black38))
      ],
    );
  }
}
