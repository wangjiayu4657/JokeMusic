import 'package:flutter/material.dart';
import '../tools/extension/int_extension.dart';

class VerticalItem extends StatelessWidget {
  const VerticalItem({
    Key? key,
    required this.icon,
    this.title,
    this.style,
    this.margin = 8,
    this.callback
  }) : super(key: key);

  final Widget icon;
  final String? title;
  final double? margin;
  final TextStyle? style;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        width: 40.px,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
