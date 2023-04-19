import 'package:flutter/material.dart';

import 'pages/main/main_page.dart';
import 'services/routes/router_config.dart';
import 'services/theme/theme_config.dart';
import 'pages/login/login_page.dart';
import 'tools/share/device_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceManager.deviceInfo();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeConfig.normalTheme,
      darkTheme: ThemeConfig.darkTheme,
      // home: const LoginPage(),
      initialRoute: MainPage.routeName,
      onGenerateRoute: RouterConfig.onGenerateRoute,
      onUnknownRoute: RouterConfig.onUnknownRoute,
    );
  }
}
