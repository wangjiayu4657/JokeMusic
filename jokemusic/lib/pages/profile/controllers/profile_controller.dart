import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/routes/route_name_config.dart';
import '../audit_result_page.dart';
import '../feedback_page.dart';
import '../models/social_info.dart';
import '../../login/login_view.dart';
import '../../Profile/setting_page.dart';
import '../../../services/http/http.dart';
import '../../../tools/share/user_manager.dart';
import '../../login/login_model.dart';
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
        Get.toNamed(RouteName.auditResult);
        break;
      case 2:
        _share(); //分享给朋友
        break;
      case 3:
        Get.toNamed(RouteName.feedback); //意见反馈
        break;
      case 4:
        Get.toNamed(RouteName.setting); //设置
        break;
      default: //我的客服
        break;
    }
  }

  ///如果没有登录则先登录, 如果已登录则跳转用户资料编辑页
  void gotoLogin() async {
    bool isLogin = await UserManager.instance.isLogin;
    Get.toNamed(isLogin ? RouteName.userEditor : RouteName.login);
  }

  ///用户信息获取
  void _userInfoRequest() async {
    String url = "/user/info";
    final response = await Http.post(url: url);
    if(response == null) return;

    final info = response["info"];
    socialInfo.value = SocialInfo.fromJson(info);

    final user = response["user"];
    final userModel = UserInfoModel.fromJson(user);
    UserManager.instance.saveUserInfo(userModel);
  }
}
