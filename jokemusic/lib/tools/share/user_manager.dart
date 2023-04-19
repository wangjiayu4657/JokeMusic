import '../../services/storage/storage.dart';
import '../../pages/login/models/user_info_model.dart';

class UserManager {
  static const String _userKey = "user_key";
  static const String _loginState = "login_state";

  //获取登录状态
  static Future<bool> get isLogin async {
    return await Storage.fetchBool(_loginState);
  }

  //保存登录状态
  static void saveLoginState(bool isLogin) {
    Storage.save<bool>(_loginState, isLogin);
  }

  //获取用户信息
  static Future<UserInfoModel> get userModel async {
    return await Storage.fetch<UserInfoModel>(_userKey);
  }

  //保存用户信息
  static saveUserModel(UserInfoModel userModel) {
    Storage.save<UserInfoModel>(_userKey, userModel);
  }


}