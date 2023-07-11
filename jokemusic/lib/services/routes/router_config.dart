import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jokemusic/pages/login/login_binding.dart';
import 'package:jokemusic/pages/profile/controllers/audit_result_controller.dart';
import 'package:jokemusic/pages/profile/controllers/change_password_controller.dart';
import 'package:jokemusic/pages/profile/controllers/user_editor_controller.dart';
import 'package:jokemusic/pages/profile/controllers/user_info_controller.dart';

import '../../pages/Main/main_page.dart';
import '../../pages/Home/home_page.dart';
import '../../pages/home/widgets/home_search.dart';
import '../../pages/video/video_page.dart';
import '../../pages/publish/publish_page.dart';
import '../../pages/message/message_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/login/login_view.dart';
import '../../pages/others/unknown_page.dart';
import '../../pages/profile/setting_page.dart';
import '../../pages/profile/user_info_page.dart';
import '../../pages/profile/user_editor_page.dart';
import '../../pages/profile/user_info_editor_page.dart';
import '../../pages/profile/account_safe_page.dart';
import '../../pages/profile/reset_password_page.dart';
import '../../pages/profile/change_password_page.dart';
import '../../pages/profile/feedback_page.dart';
import '../../pages/profile/audit_result_page.dart';



// class RouterConfig {
//   static Map<String, WidgetBuilder> routes = {
//     MainPage.routeName: (ctx) => const MainPage(),
//     HomePage.routeName: (ctx) => const HomePage(),
//     HomeSearch.routeName: (ctx) => const HomeSearch(),
//     VideoPage.routeName: (ctx) => const VideoPage(),
//     PublishPage.routeName: (ctx) => const PublishPage(),
//     MessagePage.routeName: (ctx) => const MessagePage(),
//     ProfilePage.routeName: (ctx) => const ProfilePage(),
//     LoginPage.routeName: (ctx) => const LoginPage(),
//     SettingPage.routeName: (ctx) => const SettingPage(),
//     UserInfoPage.routeName: (ctx) => const UserInfoPage(),
//     AccountSafePage.routeName: (ctx) => const AccountSafePage(),
//     ResetPasswordPage.routeName: (ctx) => const ResetPasswordPage(),
//     ChangePasswordPage.routeName: (ctx) => const ChangePasswordPage(),
//     FeedbackPage.routeName: (ctx) => const FeedbackPage(),
//     AuditResultPage.routeName: (ctx) => const AuditResultPage(),
//     UserEditorPage.routeName: (ctx) => const UserEditorPage(),
//     UserInfoEditorPage.routeName: (ctx,{arguments}) => UserInfoEditorPage(arguments: arguments),
//   };
//
//   //统一处理
//   static RouteFactory onGenerateRoute = (RouteSettings setting) {
//     final String? name = setting.name;
//     final Function? pageContentBuilder = routes[name];
//     if (pageContentBuilder == null) return null;
//     if (setting.arguments != null) {
//       return MaterialPageRoute(builder: (context) => pageContentBuilder(context, arguments: setting.arguments));
//     } else {
//       return MaterialPageRoute(builder: (context) => pageContentBuilder(context));
//     }
//   };
//
//   static RouteFactory onUnknownRoute = (setting){
//     return MaterialPageRoute(builder: (ctx) => const UnknownPage());
//   };
// }

class RouterConfigs {
  static List<GetPage> routePages = [
    GetPage(name:  MainPage.routeName, page: () => const MainPage()),
    GetPage(name:  HomePage.routeName, page: () => const HomePage()),
    GetPage(name:  HomeSearch.routeName, page: () => const HomeSearch()),
    GetPage(name:  VideoPage.routeName, page: () => const VideoPage()),
    GetPage(name:  PublishPage.routeName, page: () => const PublishPage()),
    GetPage(name:  MessagePage.routeName, page: () => const MessagePage()),
    GetPage(name:  ProfilePage.routeName, page: () => const ProfilePage()),
    GetPage(
      binding: LoginBinding(),
      name: LoginPage.routeName,
      page: () => const LoginPage()
    ),
    GetPage(name:  SettingPage.routeName, page: () => const SettingPage()),
    GetPage(
      binding: UserInfoBinding(),
      name: UserInfoPage.routeName,
      page: () => const UserInfoPage()
    ),
    GetPage(name:  AccountSafePage.routeName, page: () => const AccountSafePage()),
    GetPage(name:  ResetPasswordPage.routeName, page: () => const ResetPasswordPage()),
    GetPage(
      binding: ChangePasswordBinding(),
      name: ChangePasswordPage.routeName,
      page: () => const ChangePasswordPage()
    ),
    GetPage(name:  FeedbackPage.routeName, page: () => const FeedbackPage()),
    GetPage(
      binding: AuditResultBinding(),
      name: AuditResultPage.routeName,
      page: () => const AuditResultPage()
    ),
    GetPage(
      binding: UserEditorBinding(),
      name: UserEditorPage.routeName,
      page: () => const UserEditorPage()
    ),
    GetPage(name:  UserInfoEditorPage.routeName, page: () => const UserInfoEditorPage()),
  ];

  static RouteFactory onUnknownRoute = (setting){
    return MaterialPageRoute(builder: (ctx) => const UnknownPage());
  };
}

