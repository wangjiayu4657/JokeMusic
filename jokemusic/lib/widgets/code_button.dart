import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jokemusic/tools/extension/object_extension.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

//倒计时按钮
class CodeButton extends StatefulWidget {
  const CodeButton({
    Key? key,
    int? second,
    this.height,
    bool? isEnable,
    bool? isStartTime,
    String? startTitle,
    String? endTitle,
    this.phone,
    this.callback
  }) : second = second ?? 59,
       isEnable = isEnable ?? true,
       isStartTime = isStartTime ?? true,
       startTitle = startTitle ?? "获取验证码",
       endTitle = endTitle ?? "重新获取",
       super(key: key);

  ///倒计时的秒数
  final int second;
  final double? height;
  ///起始时的标题
  final String startTitle;
  ///倒计时结束时的标题
  final String endTitle;
  ///手机号码
  final String? phone;
  ///按钮使能
  final bool isEnable;
  ///是否开始计时
  final bool isStartTime;
  ///回调
  final VoidCallback? callback;

  @override
  State<CodeButton> createState() => _CodeButtonState();
}

class _CodeButtonState extends State<CodeButton> {
  late int second = widget.second;
  late bool _isEnable = widget.isEnable;
  late String codeTitle = widget.startTitle;

  void initTimer() {
    _isEnable = false;
    setState(() {
      codeTitle = "剩余时间: $second s";
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        second -= 1;
        codeTitle = "剩余时间: $second s";
        if (second == 0) {
          timer.cancel();
          second = widget.second;
          codeTitle = widget.endTitle;
          _isEnable = true;
        }
      });
    });
  }

  void onPressed() {
    if(widget.phone == null){
      showToast("手机号码不能为空");
      return;
    }

    widget.callback?.call();
    if(widget.isStartTime) initTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 34.px,
      padding: EdgeInsets.symmetric(horizontal: 10.px),
      child: TextButton(
        onPressed: _isEnable ? onPressed : null,
        child: Text(codeTitle,style: TextStyle(color: Colors.black26,fontSize: 14.px))
      ),
    );
  }
}
