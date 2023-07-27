import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'route_name_config.dart';
import 'route_binding_config.dart';

import '../../pages/Profile/user_info_page.dart';
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
import '../../pages/profile/user_editor_page.dart';
import '../../pages/profile/user_info_editor_page.dart';
import '../../pages/profile/account_safe_page.dart';
import '../../pages/profile/reset_password_page.dart';
import '../../pages/profile/change_password_page.dart';
import '../../pages/profile/feedback_page.dart';
import '../../pages/profile/audit_result_page.dart';
import '../../pages/profile/photo_browser_page.dart';

abstract class RouterConfig {
  static List<GetPage> routePages = [
    GetPage(name: RouteName.main, page: () => const MainPage()),
    GetPage(name: RouteName.home, page: () => const HomePage()),
    GetPage(name: RouteName.search, page: () => const HomeSearch()),
    GetPage(name: RouteName.video, page: () => const VideoPage()),
    GetPage(name: RouteName.publish, page: () => const PublishPage()),
    GetPage(name: RouteName.message, page: () => const MessagePage()),
    GetPage(name: RouteName.profile, page: () => const ProfilePage()),
    GetPage(
      name: RouteName.login,
      binding: RouteBinding.login,
      page: () => const LoginPage()
    ),
    GetPage(name: RouteName.setting, page: () => const SettingPage()),
    GetPage(
      name: RouteName.userInfo,
      binding: RouteBinding.userInfo,
      page: () => const UserInfoPage()
    ),
    GetPage(
      name: RouteName.accountSafe,
      binding: RouteBinding.accountSafe,
      page: () => const AccountSafePage()
    ),
    GetPage(name: RouteName.resetPassword, page: () => const ResetPasswordPage()),
    GetPage(
      name: RouteName.changePassword,
      binding: RouteBinding.changePassword,
      page: () => const ChangePasswordPage()
    ),
    GetPage(
      name: RouteName.feedback,
      binding: RouteBinding.feedback,
      page: () => const FeedbackPage()
    ),
    GetPage(
      name: RouteName.auditResult,
      binding: RouteBinding.auditResult,
      page: () => const AuditResultPage()
    ),
    GetPage(
      name: RouteName.userEditor,
      binding: RouteBinding.userEditor,
      page: () => const UserEditorPage()
    ),
    GetPage(name: RouteName.userInfoEditor, page: () => const UserInfoEditorPage()),
    GetPage(
      name: RouteName.photoBrowser,
      binding: RouteBinding.photoBrowser,
      page: () => const PhotoBrowserPage(),
      transition: Transition.fadeIn,
      curve: Curves.elasticInOut,
      // transitionDuration: const Duration(milliseconds: 200)
    )
  ];

  static RouteFactory onUnknownRoute = (setting){
    return MaterialPageRoute(builder: (ctx) => const UnknownPage());
  };
}


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
