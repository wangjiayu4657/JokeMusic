import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../tools/extension/int_extension.dart';

extension ObjectMap on Object {
  //将其他类型转为double类型
  double mapToDouble(dynamic val){
    if(val is int){
      return val.toDouble();
    } else if (val is double) {
      return val;
    } else {
      return double.parse(val);
    }
  }

  //将其他类型转为int类型
  int mapToInt(dynamic val) {
    if(val is int){
      return val;
    } else if (val is double) {
      return val.toInt();
    } else {
      return int.parse(val);
    }
  }

  //展示toast提示
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 14.px
    );
  }
}