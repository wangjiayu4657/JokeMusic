import 'package:flutter/material.dart';

import '../../services/theme/theme_config.dart';
import '../../tools/extension/color_extension.dart';
import '../../tools/extension/int_extension.dart';
import '../../widgets/code_button.dart';
import '../../widgets/input.dart';


class ResetPasswordPage extends StatefulWidget {
  static const String routeName = "/password_operation";
  const ResetPasswordPage({Key? key}) : super(key: key);


  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  String? _code;
  String? _phone;
  String? _password;
  bool _obscureText = false;
  bool _isCodeBtnEnable = false;
  bool _isResetBtnEnable = false;

  void codeBtnClick() {

  }

  void resetBtnClick() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  ///构建导航组件
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: 40.px,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        iconSize: 30.px,
        icon: const Icon(Icons.close,color: Colors.black26),
      ),
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }

  ///构建内容组件内
  Widget buildBody() {
    return Container(
      padding: EdgeInsets.all(15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("重置密码", style: ThemeConfig.normalTextTheme.displayLarge),
          SizedBox(height: 30.px),
          buildAccount(),
          SizedBox(height: 15.px),
          buildCode(),
          SizedBox(height: 15.px),
          buildNewPassword(),
          SizedBox(height: 25.px),
          buildResetButton(),
        ],
      ),
    );
  }

  ///构建账号输入组件
  Widget buildAccount() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: Input(
        placeholder: "请输入手机号码",
        textOffset: 0.05,
        maxLength: 11,
        valueChanged: (phoneNum) {
          _phone = phoneNum;
          setState(() {
            _isCodeBtnEnable = phoneNum?.length == 11;
            _isResetBtnEnable = phoneNum != null && _code != null && _password != null;
          });
        },
      ),
    );
  }

  ///构建验证码组件
  Widget buildCode() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: buildCodeInput()),
          buildCodeButton()
        ],
      ),
    );
  }

  ///构建验证码输入组件
  Widget buildCodeInput() {
    return Input(
      placeholder: "请输入验证码",
      textOffset: 0.05,
      valueChanged: (code) {
        _code = code;
        setState(() => _isResetBtnEnable = _phone != null && _code != null && _password != null);
      },
    );
  }

  ///构建验证码按钮组件
  Widget buildCodeButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 2.px,
          height: 15.px,
          color: Colors.black12,
        ),
        SizedBox(
          width: 130.px,
          child: CodeButton(
            second: 59,
            phone: _phone,
            style: TextStyle(fontSize: 15.px,color: Colors.black26),
            callback: _isCodeBtnEnable ? codeBtnClick : null
          )
        )
      ],
    );
  }

  ///构建新密码组件
  Widget buildNewPassword() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.only(left: 15.px),
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: buildNewPasswordInput(),
    );
  }

  ///构建新密码输入组件
  Widget buildNewPasswordInput() {
    return Input(
      placeholder: "请输入新密码(长度6~18)",
      textOffset: 0.05,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        onPressed: (){
          setState(() => _obscureText = !_obscureText);
        },
        icon: Image.asset("assets/images/normal/${_obscureText ? "eye_off.png" : "eye_on.png"}")
      ),
      valueChanged: (password) {
        _password = password;
        setState(() => _isResetBtnEnable = _phone != null && _code != null && _password != null);
      },
    );
  }

  ///构建登录按钮
  Widget buildResetButton() {
    return Container(
      height: 44.px,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: ElevatedButton(
        onPressed: _isResetBtnEnable ? resetBtnClick : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled) ? Colors.black12 : Colors.orangeAccent;
          })
        ),
        child: Text("重  置", style: ThemeConfig.normalTextTheme.displaySmall?.copyWith(color: Colors.white))
      ),
    );
  }


}
