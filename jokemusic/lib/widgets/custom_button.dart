import 'package:flutter/material.dart';

import '../services/theme/theme_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.enable,
    Color? enableColor,
    Color? disableColor,
    this.onPressed,
  }) : enableColor = enableColor ?? Colors.orangeAccent,
       disableColor = disableColor ?? Colors.black12,
       super(key: key);

  final String title;
  final bool? enable;
  final Color? enableColor;
  final Color? disableColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable ?? true ? onPressed : null,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled) ? disableColor : enableColor;
        })
      ),
      child: Text(title, style: ThemeConfig.normalTextTheme.displaySmall?.copyWith(color: Colors.white))
    );
  }
}
