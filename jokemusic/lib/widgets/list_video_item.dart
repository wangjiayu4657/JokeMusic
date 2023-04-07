import 'package:flutter/material.dart';

import '../widgets/custom_video_player.dart';
import '../../../tools/extension/int_extension.dart';


class ListVideoItem extends StatelessWidget {
  const ListVideoItem({
    Key? key,
    this.height,
    this.color,
  }) : super(key: key);

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        children: [
          buildContent(title: "在Column中的Text不用任何处理，能够自动换行在Column中的Text不用任何处理，能够自动换行"),
          buildVideoItem()
        ],
      ),
    );
  }

  Widget buildContent({String? title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title ?? "", style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w500))
      ],
    );
  }

  Widget buildVideoItem() {
    return const CustomVideoPlayer();
  }
}

