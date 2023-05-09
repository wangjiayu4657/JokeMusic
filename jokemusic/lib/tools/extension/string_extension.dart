import 'package:flutter/material.dart';

extension StringExtension on String {
  //计算字符串的大小
  static Size boundingTextSize({
    required BuildContext context,
    required String text,
    TextStyle? style,
    int maxLines = 2^31,
    double maxWidth = double.infinity
  }) {
    if (text.isEmpty) return Size.zero;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      locale: Localizations.localeOf(context),
      text: TextSpan(text: text, style: style), maxLines: maxLines
    )..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  //计算字符串的宽度
  static double calculateWidth({
    required BuildContext context,
    required String text,
    TextStyle? style,
    int maxLines = 2^31,
    double maxWidth = double.infinity
  }) {
    return boundingTextSize(
        context: context,
        text: text,
        style: style,
        maxLines: maxLines,
        maxWidth: maxWidth
    ).width;
  }

  //计算字符串的高度
  static double calculateHeight({
    required BuildContext context,
    required String text,
    TextStyle? style,
    int maxLines = 2^31,
    double maxWidth = double.infinity
  }) {
    return boundingTextSize(
      context: context,
      text: text,
      style: style,
      maxLines: maxLines,
      maxWidth: maxWidth
    ).height;
  }
}