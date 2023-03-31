import 'package:flutter/material.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class ThemeConfig {
  static final double smallFontSize = 12.px;
  static final double normalFontSize = 14.px;
  static final double mediumFontSize = 16.px;
  static final double largeFontSize = 18.px;

  //默认主题
  static const normalTextColor = Colors.black54;
  static final ThemeData normalTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.redAccent,
    splashColor: Colors.transparent,
    canvasColor: Colors.white,
    textTheme: normalTextTheme,
    textButtonTheme:buttonTheme,
    highlightColor: Colors.transparent,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black12),
    elevatedButtonTheme: elevatedButtonThemeData
  );

  static final TextTheme normalTextTheme = TextTheme(
    bodyText1: TextStyle(fontSize: normalFontSize, color: normalTextColor,fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: normalFontSize, color: normalTextColor), //默认使用

    headline1: TextStyle(fontSize: largeFontSize, color: normalTextColor),
    headline2: TextStyle(fontSize: mediumFontSize, color: normalTextColor),
    headline3: TextStyle(fontSize: smallFontSize, color: normalTextColor),
  );

  //暗黑主题
  static const Color darkTextColor = Colors.white12;
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    splashColor: Colors.transparent,
    canvasColor: const Color.fromARGB(1, 255, 254, 222),
    textTheme:  darkTextTheme,
  );
  static final TextTheme darkTextTheme = TextTheme(
    bodyText1: TextStyle(fontSize: normalFontSize, color: darkTextColor,fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: normalFontSize, color: darkTextColor),

    headline1: TextStyle(fontSize: largeFontSize, color: darkTextColor),
    headline2: TextStyle(fontSize: mediumFontSize, color: darkTextColor),
    headline3: TextStyle(fontSize: smallFontSize, color: darkTextColor),
  );


  static TextButtonThemeData buttonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states){
        return states.contains(MaterialState.pressed) ? Colors.black12 : Colors.transparent;
      }),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 15.px))
    )
  );

  static ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states){
        return states.contains(MaterialState.pressed) ? Colors.black12 : Colors.transparent;
      }),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 15.px))
    )
  );
}
