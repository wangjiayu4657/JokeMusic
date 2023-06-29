import 'package:flutter/material.dart';

import '../tools/extension/int_extension.dart';
import '../tools/extension/color_extension.dart';

enum BorderType {
  noBorder, //无边框
  outlineBorder, //四周都有边框
  underlineBorder //底部有边框
}

//输入框
class Input extends StatefulWidget {
  const Input({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.controller,
    this.hintStyle,
    this.borderType = BorderType.noBorder,
    this.borderWidth = 1,
    Color? borderColor,
    this.placeholder,
    this.autofocus,
    this.keyboardType,
    this.obscureText,
    this.contentPadding,
    double? textOffset,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.valueChanged,
  }) : borderColor = ColorExtension.lineColor,
       textOffset = textOffset ?? 0,
       super(key: key);

  ///输入框前面的组件
  final Widget? prefixIcon;
  ///输入框末尾的组件
  final Widget? suffixIcon;
  ///占位符字体样式
  final TextStyle? hintStyle;
  ///边框风格
  final BorderType? borderType;
  ///边框宽度
  final double? borderWidth;
  ///边框颜色
  final Color borderColor;
  ///输入文本是否为密码
  final bool? obscureText;
  ///占位符
  final String? placeholder;
  ///是否自动聚焦
  final bool? autofocus;
  ///键盘样式
  final TextInputType? keyboardType;
  ///文本输入时的回调
  final ValueChanged? valueChanged;
  ///内容内边距
  final EdgeInsets? contentPadding;
  ///文本垂直对齐偏移量,取值范围: -1.0 ~ 1.0
  final double textOffset;
  ///最小行数,默认为0行
  final int? minLines;
  ///最大行数,默认为1行
  final int? maxLines;
  ///最大字符数(字符串长度)
  final int? maxLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(textBaseline: TextBaseline.alphabetic,height: 1.25),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ?? false,
      onChanged: widget.valueChanged,
      cursorColor: Colors.black12,
      cursorHeight: 15.px,
      focusNode: widget.focusNode,
      controller: widget.controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus ?? false,
      textAlignVertical: TextAlignVertical(y: widget.textOffset),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: widget.hintStyle ?? TextStyle(fontSize: 15.px, color: Colors.black26, fontWeight: FontWeight.normal),
        prefixIconColor: Colors.black54,
        focusColor: Colors.black54,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixIconConstraints: BoxConstraints(minWidth: 34.px),
        counterText: '',
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        disabledBorder: buildBorder(),
        contentPadding: widget.contentPadding ?? EdgeInsets.zero
      ),
    );
  }

  ///构建边框
  InputBorder buildBorder() {
    if(widget.borderType == BorderType.noBorder){
      return buildOutlineBorder(1,Colors.transparent);
    } else if(widget.borderType == BorderType.outlineBorder){
      return buildOutlineBorder(widget.borderWidth ?? 1,widget.borderColor);
    } else {
      return buildUnderLineBorder(widget.borderWidth ?? 0.5,widget.borderColor);
    }
  }

  //构建四周边框
  OutlineInputBorder buildOutlineBorder(double width,Color color) {
    return OutlineInputBorder(borderSide: BorderSide(width: width,color: color));
  }

  //构建底部边框
  UnderlineInputBorder buildUnderLineBorder(double width,Color color) {
    return UnderlineInputBorder(borderSide: BorderSide(width: width, color: color));
  }
}
