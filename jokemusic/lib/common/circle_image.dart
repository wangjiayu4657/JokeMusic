import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    Key? key,
    required this.corner,
    this.style,
    this.borderColor,
    this.borderWidth
  }) : super(key: key);
  
  final double corner;
  final Color? borderColor;
  final double? borderWidth;
  final BorderStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: corner * 2,
      height: corner * 2,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth ?? 0, 
          style: style ?? BorderStyle.none,
          color: borderColor ?? Colors.transparent
        ),
        borderRadius: BorderRadius.circular(corner)
      ),
      child: Image.asset("source/images/placeholder"),
    );
  }
}
