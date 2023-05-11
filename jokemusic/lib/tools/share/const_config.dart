import 'dart:ui';

final double dpr = window.devicePixelRatio;
final double statusHeight = window.padding.top / dpr;
final double width = window.physicalSize.width / dpr;
final double height = window.physicalSize.height / dpr;
final double ratio = width / 750;  //宽高比


// 软键盘高度
double get keyboardHeight {
  return window.viewInsets.bottom / dpr;
}
