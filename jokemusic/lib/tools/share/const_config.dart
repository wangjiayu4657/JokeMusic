import 'dart:ui';
import 'package:flutter/cupertino.dart';

final FlutterView keyWindow = WidgetsBinding.instance.platformDispatcher.views.first;
final double dpr = keyWindow.devicePixelRatio;
final double statusHeight = keyWindow.padding.top / dpr;
final double width = keyWindow.physicalSize.width / dpr;
final double height = keyWindow.physicalSize.height / dpr;
final double ratio = width / 750;  //宽高比


// 软键盘高度
double get keyboardHeight {
  return keyWindow.viewInsets.bottom / dpr;
}
