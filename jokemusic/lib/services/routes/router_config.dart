import 'package:flutter/material.dart';

import '../../pages/Main/main_page.dart';
import '../../pages/Home/home_page.dart';
import '../../pages/home/widgets/home_search.dart';
import '../../pages/video/video_page.dart';
import '../../pages/publish/publish_page.dart';
import '../../pages/message/message_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/login/login_page.dart';
import '../../pages/others/unknown_page.dart';
import '../../pages/profile/setting_page.dart';
import '../../pages/profile/user_info_page.dart';
import '../../pages/profile/account_safe_page.dart';
import '../../pages/profile/reset_password_page.dart';
import '../../pages/profile/change_password_page.dart';
import '../../pages/profile/feedback_page.dart';
import '../../pages/profile/audit_result_page.dart';



class RouterConfig {
  static Map<String, WidgetBuilder> routes = {
    MainPage.routeName: (ctx) => const MainPage(),
    HomePage.routeName: (ctx) => const HomePage(),
    HomeSearch.routeName: (ctx) => const HomeSearch(),
    VideoPage.routeName: (ctx) => const VideoPage(),
    PublishPage.routeName: (ctx) => const PublishPage(),
    MessagePage.routeName: (ctx) => const MessagePage(),
    ProfilePage.routeName: (ctx) => const ProfilePage(),
    LoginPage.routeName: (ctx) => const LoginPage(),
    SettingPage.routeName: (ctx) => const SettingPage(),
    UserInfoPage.routeName: (ctx) => const UserInfoPage(),
    AccountSafePage.routeName: (ctx) => const AccountSafePage(),
    ResetPasswordPage.routeName: (ctx) => const ResetPasswordPage(),
    ChangePasswordPage.routeName: (ctx) => const ChangePasswordPage(),
    FeedbackPage.routeName: (ctx) => const FeedbackPage(),
    AuditResultPage.routeName: (ctx) => const AuditResultPage(),
    // DisplayPicturePage.routeName: (ctx,{arguments}) => DisplayPicturePage(path: arguments),
  };

  //统一处理
  static RouteFactory onGenerateRoute = (RouteSettings setting) {
    final String? name = setting.name;
    final Function? pageContentBuilder = routes[name];
    if (pageContentBuilder == null) return null;
    if (setting.arguments != null) {
      return MaterialPageRoute(builder: (context) => pageContentBuilder(context, arguments: setting.arguments));
    } else {
      return MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    }
  };

  static RouteFactory onUnknownRoute = (setting){
    return MaterialPageRoute(builder: (ctx) => const UnknownPage());
  };
}

