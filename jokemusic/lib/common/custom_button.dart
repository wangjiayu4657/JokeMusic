import 'package:flutter/material.dart';
import 'package:jokemusic/tools/extension/int_extension.dart';

import '../services/theme/theme_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.style,
    this.enable,
    this.width,
    this.height,
    this.radius,
    this.bordColor,
    this.backgroundColor,
    Color? enableColor,
    Color? disableColor,
    this.onPressed,
  }) : enableColor = enableColor ?? Colors.orangeAccent,
       disableColor = disableColor ?? Colors.black12,
       super(key: key);

  final String title;
  final TextStyle? style;
  final bool? enable;
  final double? width;
  final double? height;
  final double? radius;
  final Color? bordColor;
  final Color? backgroundColor;
  final Color? enableColor;
  final Color? disableColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100.px,
      height: height ?? 34.px,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: bordColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(radius ?? 0)
      ),
      child: ElevatedButton(
        onPressed: enable ?? true ? onPressed : null,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled) ? disableColor : enableColor;
          })
        ),
        child: Text(title, style: style ?? ThemeConfig.normalTextTheme.displaySmall?.copyWith(color: style?.color))
      ),
    );
  }
}
