import 'dart:math';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  ///背景颜色
  static Color bgColor = ColorExtension.hex("#F7F7F7");
  ///线条颜色
  static const Color lineColor = Color.fromRGBO(233, 233, 233, 0.5);
  ///material color
  static MaterialColor primarySwatch = mapMaterialColor(Colors.white);
  ///随机颜色
  static Color randomColor = getRandomColor();


  // String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  ///根据color创建 MaterialColor
  static MaterialColor mapMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static Color getRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
    if (r == 0 || g == 0 || b == 0) return Colors.black;
    if (a == 0) return Colors.white;
    return Color.fromARGB(
      a,
      r != 255 ? r : Random.secure().nextInt(r),
      g != 255 ? g : Random.secure().nextInt(g),
      b != 255 ? b : Random.secure().nextInt(b),
    );
  }
}