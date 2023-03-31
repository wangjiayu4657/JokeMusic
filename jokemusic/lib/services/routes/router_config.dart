import 'package:flutter/material.dart';

import '../../pages/Main/main_page.dart';
import '../../pages/Home/home_page.dart';
import '../../pages/video/video_page.dart';
import '../../pages/publish/publish_page.dart';
import '../../pages/message/message_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/others/unknown_page.dart';


class RouterConfig {
  static Map<String, WidgetBuilder> routes = {
    MainPage.routeName: (ctx) => const MainPage(),
    HomePage.routeName: (ctx) => const HomePage(),
    VideoPage.routeName: (ctx) => const VideoPage(),
    PublishPage.routeName: (ctx) => const PublishPage(),
    MessagePage.routeName: (ctx) => const MessagePage(),
    ProfilePage.routeName: (ctx) => const ProfilePage(),
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

