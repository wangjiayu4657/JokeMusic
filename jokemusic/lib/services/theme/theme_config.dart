import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tools/extension/int_extension.dart';


class ThemeConfig {
  static final double smallFontSize = 12.px;
  static final double normalFontSize = 14.px;
  static final double mediumFontSize = 16.px;
  static final double largeFontSize = 18.px;

  //默认主题
  static const normalTextColor = Colors.black87;
  static final ThemeData normalTheme = ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.white,
    splashColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    canvasColor: Colors.white,
    appBarTheme: appBarTheme,
    textTheme: normalTextTheme,
    textButtonTheme:buttonTheme,
    buttonTheme: buttonThemeData,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black12),
    elevatedButtonTheme: elevatedButtonThemeData
  );

  static final TextTheme normalTextTheme = TextTheme(
    labelSmall: TextStyle(fontSize: 12.px, color: normalTextColor),
    labelMedium: TextStyle(fontSize: 14.px, color: normalTextColor),
    labelLarge: TextStyle(fontSize: 16.px, color: normalTextColor),

    bodySmall: TextStyle(fontSize: 12.px, color: normalTextColor),
    bodyMedium: TextStyle(fontSize: 14.px, color: normalTextColor),
    bodyLarge: TextStyle(fontSize: 16.px, color: normalTextColor),

    titleSmall: TextStyle(fontSize: 12.px,  color: normalTextColor),
    titleMedium: TextStyle(fontSize: 14.px, color: normalTextColor, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 18.px, color: normalTextColor),

    headlineSmall: TextStyle(fontSize: 12.px, color: normalTextColor),
    headlineMedium: TextStyle(fontSize: 16.px, color: normalTextColor),
    headlineLarge: TextStyle(fontSize: 20.px, color: normalTextColor),

    displaySmall: TextStyle(fontSize: 16.px, color: normalTextColor),
    displayMedium: TextStyle(fontSize: 20.px, color: normalTextColor),
    displayLarge: TextStyle(fontSize: 24.px, color: normalTextColor)
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
    labelSmall: TextStyle(fontSize: 12.px, color: darkTextColor),
    labelMedium: TextStyle(fontSize: 14.px, color: darkTextColor),
    labelLarge: TextStyle(fontSize: 16.px, color: darkTextColor),

    bodySmall: TextStyle(fontSize: 12.px, color: darkTextColor),
    bodyMedium: TextStyle(fontSize: 14.px, color: darkTextColor),
    bodyLarge: TextStyle(fontSize: 16.px, color: darkTextColor),

    titleSmall: TextStyle(fontSize: 12.px,  color: darkTextColor),
    titleMedium: TextStyle(fontSize: 14.px, color: darkTextColor),
    titleLarge: TextStyle(fontSize: 18.px, color: darkTextColor),

    headlineSmall: TextStyle(fontSize: 12.px, color: darkTextColor),
    headlineMedium: TextStyle(fontSize: 16.px, color: darkTextColor),
    headlineLarge: TextStyle(fontSize: 20.px, color: darkTextColor),

    displaySmall: TextStyle(fontSize: 16.px, color: darkTextColor),
    displayMedium: TextStyle(fontSize: 20.px, color: darkTextColor),
    displayLarge: TextStyle(fontSize: 24.px, color: darkTextColor)
  );

  static const AppBarTheme appBarTheme = AppBarTheme(
    foregroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle.light
  );

  static TextButtonThemeData buttonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
        primary: Colors.white,
        splashFactory: NoSplash.splashFactory
    ),
    // style: ButtonStyle(
    //   backgroundColor: MaterialStateProperty.resolveWith((states){
    //     return states.contains(MaterialState.pressed) ? Colors.transparent : Colors.transparent;
    //   }),
    //   textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 15.px))
    // )
  );

  static ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        splashFactory: NoSplash.splashFactory
    ),

    // style: ButtonStyle(
    //   backgroundColor: MaterialStateProperty.resolveWith((states){
    //     return states.contains(MaterialState.pressed) ? Colors.transparent : Colors.transparent;
    //   }),
    //   textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 15.px))
    // )
  );

  static ButtonThemeData buttonThemeData = const ButtonThemeData(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  );
}
