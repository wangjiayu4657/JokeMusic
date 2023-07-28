import 'dart:async';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../models/social_info.dart';
import '../../../services/http/http.dart';
import '../../../services/routes/route_name_config.dart';
import '../../../tools/event_bus/event_bus.dart';
import '../../../tools/share/user_manager.dart';
import '../../login/login_model.dart';

class ProfileController extends GetxController {
  late SocialInfo? socialInfo = SocialInfo();
  late UserInfoModel? userInfo = UserInfoModel();
  late StreamSubscription? _subscription;

  final List<String> titles = const ["我的客服","审核结果","分享给朋友","意见反馈","设置"];
  final List<String> images = const ["customer","auditing","share","feedback","setting"];

  @override
  void onInit() {
   _subscription = bus.on<LoginEvent>().listen((event) {
      _userInfoRequest();
    });

   _initUserInfo();

   _userInfoRequest();

    super.onInit();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

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
    if(response.data == null) return;

    final info = response.data["info"];
    socialInfo = SocialInfo.fromJson(info);

    final user = response.data["user"];
    final userModel = UserInfoModel.fromJson(user);
    UserManager.instance.saveUserInfo(userModel);

    update(['profile_user_info']);
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}