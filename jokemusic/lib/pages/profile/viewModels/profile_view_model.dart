import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '../audit_result_page.dart';
import '../feedback_page.dart';
import '../models/social_info.dart';
import '../../login/login_page.dart';
import '../../Profile/setting_page.dart';
import '../../../services/http/http_client.dart';
import '../../../tools/share/user_manager.dart';
import '../../../pages/login/models/user_info_model.dart';
import '../../../pages/profile/user_editor_page.dart';
import '../../../pages/profile/user_editor_page2.dart';

class ProfileViewModel extends ChangeNotifier {
  SocialInfo? socialInfo;

  ProfileViewModel() {
    _userInfoRequest();
  }

  ///分享
  Future<void> _share() async {
    await Share.shareXFiles(
      [XFile("path")],
    );
  }

  ///处理列表item的点击事件
  void handlerItemClick({required BuildContext context, int tag = 0}) {
    switch(tag){
      case 1: Navigator.pushNamed(context, AuditResultPage.routeName);      //审核结果
      break;
      case 2: _share();                                                      //分享给朋友
      break;
      case 3: Navigator.pushNamed(context, FeedbackPage.routeName);         //意见反馈
      break;
      case 4: Navigator.pushNamed(context, SettingPage.routeName);          //设置
      break;
      default:                                                              //我的客服
        break;
    }
  }

  ///如果没有登录则先登录, 如果已登录则跳转用户资料编辑页
  void gotoLogin(BuildContext context) async {
    final navigator = Navigator.of(context);
    bool isLogin = await UserManager.instance.isLogin;
    navigator.pushNamed(isLogin ? UserEditorPage2.routeName : LoginPage.routeName);
  }

  ///用户信息获取
  void _userInfoRequest() async {
    String url = "/user/info";
    final result = await HttpClient.request(url: url);
    print("result === $result");

    final info = result["info"];
    socialInfo = SocialInfo.fromJson(info);

    final user = result["user"];
    final userModel = UserInfoModel.fromJson(user);
    UserManager.instance.saveUserInfo(userModel);

    notifyListeners();
  }
}