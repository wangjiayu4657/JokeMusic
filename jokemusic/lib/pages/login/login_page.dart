import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:jokemusic/tools/extension/object_extension.dart';

import '../../widgets/input.dart';
import '../../widgets/code_button.dart';
import '../../services/http/http_client.dart';
import '../../services/theme/theme_config.dart';
import '../../tools/share/const_config.dart';
import '../../tools/share/device_manager.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //是否为验证码登录
  bool _isCodeLogin = false;
  //登录按钮是否能交互
  bool _isLoginBtnEnable = false;

  String? phone;
  String? pwd;

  @override
  void initState() {
    super.initState();

    DeviceManager.deviceInfo();
  }
  
  void loginRequest() {
    if(phone == null) {
      showToast("请输入账户名");
      return;
    }
    if(pwd == null) {
      showToast("请输入密码");
      return;
    }

    final params = {"phone": phone, "psw": pwd};
    HttpClient.request(url: "/user/login/psw",params: params).then((value){
      debugPrint("value === $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildLoginStyle(),
    );
  }

  //构建导航组件
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: 40.px,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        iconSize: 30.px,
        icon: const Icon(Icons.close),
      ),
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }

  //构建内容组件内
  Widget buildBody() {
    return Container(
      padding: EdgeInsets.all(15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("验证码登录", style: ThemeConfig.normalTextTheme.headline1),
          SizedBox(height: 30.px),
          buildAccount(),
          SizedBox(height: 15.px),
          buildPassword(),
          SizedBox(height: 25.px),
          buildLoginButton(),
          buildLoginTool()
        ],
      ),
    );
  }

  //构建账号输入组件
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
        textOffset: 0.1,
        valueChanged: (phoneNum) {
          phone = phoneNum;
          setState(() {
            _isLoginBtnEnable = phone != null && pwd != null;
          });
        },
      ),
    );
  }

  //构建账号输入组件
  Widget buildPassword() {
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
           Expanded(
            child: Input(
              placeholder: _isCodeLogin ? "请输入密码" : "请输入验证码",
              textOffset: 0.1,
              valueChanged: (password) {
                pwd = password;
                setState(() {
                  _isLoginBtnEnable = phone != null && pwd != null;
                });
              },
            ),
          ),
          if(!_isCodeLogin) buildCodeButton()
        ],
      ),
    );
  }

  //构建验证码按钮组件
  Widget buildCodeButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 2.px,
          height: 15.px,
          color: Colors.black26,
        ),
        SizedBox(
          width: 120.px,
          child: CodeButton(second: 5, callback: () {

          })
        )
      ],
    );
  }

  //构建登录按钮
  Widget buildLoginButton() {
    return Container(
      height: 44.px,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: ElevatedButton(
        onPressed: _isLoginBtnEnable ? loginRequest : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.disabled)) return Colors.black12;
            return Colors.orangeAccent;
          })
        ),
        child: Text("登  录", style: ThemeConfig.normalTextTheme.headline3?.copyWith(color: Colors.white))
      ),
    );
  }

  //构建登录工具组件
  Widget buildLoginTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLoginToolPwdOrCodeLogin(),
        buildLoginToolQuestion()
      ],
    );
  }

  //构建登录工具 - 密码/验证码按钮组件
  Widget buildLoginToolPwdOrCodeLogin() {
    return TextButton(
      onPressed: () => setState(() => _isCodeLogin = !_isCodeLogin),
      child: Text( _isCodeLogin ? "验证码登录" : "密码登录")
    );
  }

  //构建登录工具 - 问题组件
  Widget buildLoginToolQuestion() {
    return TextButton(
      onPressed: (){},
      child: const Text("遇到问题?")
    );
  }

  //构建登录方式组件
  Widget buildLoginStyle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildLoginStyleHeader(),
        SizedBox(height: 15.px),
        buildLoginStyleOperation(),
        SizedBox(height: 20.px),
        buildLoginStyleFooter(),
        SizedBox(height: 20.px)
      ],
    );
  }

  //构建登录方式组件 - 头部
  Widget buildLoginStyleHeader() {
    return Text("其他登录方式", style: TextStyle(fontSize: 14.px,color: Colors.black54));
  }

  //构建登录方式组件 - qq/weibo/weixin
  Widget buildLoginStyleOperation() {
    return SizedBox(
      width: width - 120.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildLoginStyleOperationButton("assets/images/login/qq.png",tag: 0),
          buildLoginStyleOperationButton("assets/images/login/weibo.png",tag: 1),
          buildLoginStyleOperationButton("assets/images/login/weixin.png",tag: 2),
        ],
      ),
    );
  }

  //构建登录方式按钮组件
  Widget buildLoginStyleOperationButton(String name,{int tag = 0})  {
    return InkWell(
      onTap: (){
        debugPrint("tag == $tag");
      },
      child: SizedBox(
        width: 48.px,
        height: 48.px,
        child: Image.asset(name,fit: BoxFit.fill),
      ),
    );
  }

  //构建登录方式组件 - 底部说明组件
  Widget buildLoginStyleFooter() {
    return SizedBox(
      width: width - 120.px,
      child: RichText(
          text: TextSpan(
            text: "登录/注册代表您同意段子乐",
            style: const TextStyle(color: Colors.black54),
            children: [
              TextSpan(
                text: "《隐私政策》",
                style: const TextStyle(color: Colors.orangeAccent),
                recognizer: TapGestureRecognizer()..onTap
              ),
              const TextSpan(text: "和"),
              const TextSpan(text: "《用户服务协议》",style: TextStyle(color:Colors.orangeAccent))
            ]
          ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
