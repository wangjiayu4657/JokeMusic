import 'package:flutter/material.dart';
import '../tools/extension/int_extension.dart';

class VerticalItem extends StatelessWidget {
  const VerticalItem({
    Key? key,
    required this.icon,
    this.title,
    this.style,
    this.padding,
    this.width,
    this.height,
    this.margin = 8,
    this.callback
  }) : super(key: key);

  final Widget icon;
  final String? title;
  final double? width;
  final double? height;
  final double? margin;
  final TextStyle? style;
  final EdgeInsets? padding;
  final VoidCallback? callback;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: margin),
            Text(title ?? "", style: style ?? TextStyle(fontSize: 14.px, color: Colors.black87))
          ],
        ),
      ),
    );
  }
}
