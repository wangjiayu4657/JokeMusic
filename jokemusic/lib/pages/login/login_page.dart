import 'package:flutter/material.dart';

import 'viewModels/login_view_model.dart';
import '../../widgets/user_notice.dart';
import '../../widgets/input.dart';
import '../../widgets/code_button.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../services/theme/theme_config.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = "/LoginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///用户名
  String? _userName;
  ///密码/验证码
  String? _password;
  ///是否为验证码登录
  bool _isCodeLogin = false;
  ///是否为密码状态
  bool _obscureText = true;
  ///验证码按钮是否可点
  bool get isCodeBtnEnable => _userName?.length == 11;
  ///登录按钮是否能交互
  bool get isLoginBtnEnable => _userName != null && _password != null;

  late final _textCtrl = TextEditingController();
  late final LoginViewModel _viewModel = LoginViewModel();

  ///验证码请求
  void codeRequest() {
    _viewModel.codeRequest(phone: _userName);
  }

  ///登录请求
  void loginRequest() {
    if(_isCodeLogin) {
      _viewModel.loginCodeRequest(
        code: _password,
        userName: _userName,
        callback: () => Navigator.pop(context)
      );
    } else {
      _viewModel.loginPwdRequest(
        userName: _userName,
        password: _password,
        callback: () => Navigator.pop(context)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildLoginStyle(),
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
          Text("验证码登录", style: ThemeConfig.normalTextTheme.displayLarge),
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
        textOffset: 0.1,
        maxLength: 11,
        valueChanged: (phoneNum) {
          _userName = phoneNum;
          setState(() {});
        },
      ),
    );
  }

  ///构建密码输入组件
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
          Expanded(child: buildPasswordInput()),
          if(_isCodeLogin) buildCodeButton()
        ],
      ),
    );
  }

  ///构建密码输入组件
  Widget buildPasswordInput() {
    return Input(
      placeholder: _isCodeLogin ? "请输入验证码" : "请输入密码",
      obscureText: _isCodeLogin ? false : _obscureText,
      textOffset: 0.03,
      controller: _textCtrl,
      suffixIcon: IconButton(
        onPressed: (){
          if(_isCodeLogin) return;
          setState(() => _obscureText = !_obscureText);
        },
        icon: SizedBox(
          width: 20.px,
          height: 20.px,
          child: _isCodeLogin ?
              const SizedBox() :
              Image.asset("assets/images/normal/${_obscureText ? "eye_off.png" : "eye_on.png"}")
        )
      ),
      valueChanged: (password) {
        _password = password;
        setState(() {});
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
          width: 120.px,
          child: CodeButton(
            second: 59,
            phone: _userName,
            style: isCodeBtnEnable ? TextStyle(fontSize: 14.px, color: Colors.orangeAccent) : TextStyle(fontSize: 14.px,color: Colors.black26),
            callback: codeRequest
          )
        )
      ],
    );
  }

  ///构建登录按钮
  Widget buildLoginButton() {
    return Container(
      height: 44.px,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.px)
      ),
      child: ElevatedButton(
        onPressed: isLoginBtnEnable ? loginRequest : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()), //设置圆角弧度
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.disabled)) return Colors.black12;
            return Colors.orangeAccent;
          })
        ),
        child: Text("登  录", style: ThemeConfig.normalTextTheme.displaySmall?.copyWith(color: Colors.white))
      ),
    );
  }

  ///构建登录工具组件
  Widget buildLoginTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLoginToolPwdOrCodeLogin(),
        buildLoginToolQuestion()
      ],
    );
  }

  ///构建登录工具 - 密码/验证码按钮组件
  Widget buildLoginToolPwdOrCodeLogin() {
    return TextButton(
      onPressed: () {
        _textCtrl.text = "";
        setState(() => _isCodeLogin = !_isCodeLogin);
      },
      child: Text( _isCodeLogin ? "密码登录" : "验证码登录",style: const TextStyle(color: Colors.orangeAccent))
    );
  }

  ///构建登录工具 - 问题组件
  Widget buildLoginToolQuestion() {
    return TextButton(
      onPressed: (){
        showModalBottomSheet(
          context: context,
          builder: (context) => buildBottomSheet()
        );
      },
      child: const Text("遇到问题?", style: TextStyle(color: Colors.orangeAccent))
    );
  }

  ///构建登录方式组件
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

  ///构建登录方式组件 - 头部
  Widget buildLoginStyleHeader() {
    return Text("其他登录方式", style: TextStyle(fontSize: 14.px,color: Colors.black54));
  }

  ///构建登录方式组件 - qq/weibo/weixin
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

  ///构建登录方式按钮组件
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

  ///构建登录方式组件 - 底部用户须知组件
  Widget buildLoginStyleFooter() {
    return const UserNotice();
  }

  ///构建底部弹窗
  Widget buildBottomSheet() {
    const List<SheetItem> items = [
      SheetItem(title: "忘记密码", type: SheetItemType.forgot),
      SheetItem(title: "联系客服", type: SheetItemType.customer),
      SheetItem(title: "我要反馈", type: SheetItemType.feedback),
    ];
    return const CustomBottomSheet(items: items);
  }
}
