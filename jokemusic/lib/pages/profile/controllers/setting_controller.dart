import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../tools/share/user_manager.dart';
import '../../../tools/extension/object_extension.dart';
import '../../../services/storage/storage.dart';
import '../../Profile/user_info_page.dart';
import '../account_safe_page.dart';
import '../models/setting_model.dart';

class SettingController extends GetxController {
  List<SettingModel> list = []; //数据源
  bool autoPlay = false; //视频自动播放
  bool dataPlay = false; //使用数据网络直接播放视频
  late var packageInfo = PackageInfo(
      appName: "Unknown",
      packageName: "Unknown",
      version: "Unknown",
      buildNumber: "Unknown",
      buildSignature: "Unknown",
      installerStore: "Unknown");


  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  ///初始化数据
  void _initData() async {
    //用户相关
    const users = ["用户信息", "账号安全"];
    final userModel = SettingModel.initModel(section: 0, title: "用户相关", names: users);

    //通用
    const generals = ["推送开关", "视频自动播放", "数据网络直接播放视频", "清除缓存"];
    final generalModel = SettingModel.initModel(section: 1, title: "通用", names: generals);

    //其他设置
    const others = ["给我评分", "检查更新", "用户服务协议", "隐私政策", "关于我们"];
    final otherModel = SettingModel.initModel(section: 2, title: "其他设置", names: others);

    list = [userModel, generalModel, otherModel];

    final info = await PackageInfo.fromPlatform();

    //初始化packageInfo组件
    packageInfo = info;

    update();
  }


  void changeValue({int idx = 0, bool val = false}){
    idx == 1 ? autoPlay = val : dataPlay = val;
    update();
  }

  ///处理列表item的点击事件
  void handlerItemSelected({int section = 0, int row = 0}) {
    switch (section) {
      case 0:
        if (row == 0) {
          //用户信息
          Get.toNamed(UserInfoPage.routeName);
        } else {
          //账号安全
          Get.toNamed(AccountSafePage.routeName);
        }
        break;
      case 1:
        if (row == 0) {
          //推送开关
        } else if (row == 3) {
          //清除缓存
        }
        break;
      case 2:
        if (row == 0) {
          //给我评分
        } else if (row == 1) {
          //检查更新
        } else if (row == 2) {
          //用户服务协议
        } else if (row == 3) {
          //隐私政策
        } else {
          //关于我们
        }
        break;
      default:
        break;
    }
  }

  void logoutRequest() async {
    // final isLogin = await UserManager.instance.isLogin;
    await Storage.remove("token");
    UserManager.instance.saveLoginState(false);
    showToast("退出成功");
    Get.back();
  }
}

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}