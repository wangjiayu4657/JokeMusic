import 'package:flutter/material.dart';

extension StringExtension on String {
  //计算字符串的大小
  Size boundingTextSize({
    required BuildContext context,
    // required String text,
    TextStyle? style,
    int maxLines = 2^31,
    double maxWidth = double.infinity
  }) {
    if (isEmpty) return Size.zero;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      locale: Localizations.localeOf(context),
      text: TextSpan(text: this, style: style), maxLines: maxLines
    )..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  //计算字符串的宽度
  double calculateWidth({
    required BuildContext context,
    // required String text,
    TextStyle? style,
    int maxLines = 2^31,
    double maxWidth = double.infinity
  }) {
    return boundingTextSize(
        context: context,
        // text: text,
        style: style,
        maxLines: maxLines,
        maxWidth: maxWidth
    ).width;
  }

  //计算字符串的高度
  double calculateHeight({
    required BuildContext context,
    // required String text,
    TextStyle? style,
    int maxLines = 2^31,
    double maxWidth = double.infinity
  }) {
    return boundingTextSize(
      context: context,
      // text: text,
      style: style,
      maxLines: maxLines,
      maxWidth: maxWidth
    ).height;
  }
}