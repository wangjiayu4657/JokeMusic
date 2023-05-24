import 'package:flutter/material.dart';

import '../../services/storage/storage.dart';
import '../../pages/login/models/user_info_model.dart';

///用户信息管理类
class UserManager {
  static final _instance = UserManager._internal();
  static const String _userKey = "user_key";
  static const String _loginState = "login_state";

  ///工厂构造函数
  factory UserManager() => _instance;
  ///get方法
  static UserManager get instance => _instance;
  ///构造函数私有化，防止被误创建
  UserManager._internal();

  ///获取登录状态
  Future<bool> get isLogin async {
    return await Storage.fetchBool(_loginState);
  }

  ///保存登录状态
  void saveLoginState(bool isLogin) {
    Storage.save<bool>(_loginState, isLogin);
  }

  ///获取用户信息
  Future<UserInfoModel> get userModel async {
    return await Storage.fetch<UserInfoModel>(_userKey);
  }

  ///保存用户信息
  saveUserInfo(UserInfoModel userModel) {
    Storage.save<UserInfoModel>(_userKey, userModel);
  }

  ///删除用户信息
  removeUserInfo() {
    Storage.remove(_userKey);
  }
}
