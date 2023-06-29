import 'package:get/get.dart';
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

class ProfileController extends GetxController {
  final socialInfo = SocialInfo().obs;
  UserInfoModel? userInfo = UserInfoModel();

  ProfileController() {
    _initUserInfo();
    _userInfoRequest();
  }

  static ProfileController get to => Get.find();

  ///获取用户信息
  void _initUserInfo() async {
    userInfo = await UserManager.instance.userModel;
    update(['profile_header_info']);
  }

  ///分享
  Future<void> _share() async {
    await Share.shareXFiles(
      [XFile("path")],
    );
  }

  ///处理列表item的点击事件
  void handlerItemClick({int tag = 0}) {
    switch (tag) {
      case 1:
        Get.toNamed(AuditResultPage.routeName);
        break;
      case 2:
        _share(); //分享给朋友
        break;
      case 3:
        Get.toNamed(FeedbackPage.routeName); //意见反馈
        break;
      case 4:
        Get.toNamed(SettingPage.routeName); //设置
        break;
      default: //我的客服
        break;
    }
  }

  ///如果没有登录则先登录, 如果已登录则跳转用户资料编辑页
  void gotoLogin() async {
    bool isLogin = await UserManager.instance.isLogin;
    Get.toNamed(isLogin ? UserEditorPage.routeName : LoginPage.routeName);
  }

  ///用户信息获取
  void _userInfoRequest() async {
    String url = "/user/info";
    final response = await HttpClient.request(url: url);

    final result = response["data"];
    final info = result["info"];
    socialInfo.value = SocialInfo.fromJson(info);

    final user = result["user"];
    final userModel = UserInfoModel.fromJson(user);
    UserManager.instance.saveUserInfo(userModel);
  }
}
