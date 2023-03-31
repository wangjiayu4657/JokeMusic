import 'package:flutter/material.dart';

import 'pages/main/main_page.dart';
import 'services/routes/router_config.dart';
import 'services/theme/theme_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.normalTheme,
      darkTheme: ThemeConfig.darkTheme,
      initialRoute: MainPage.routeName,
      onGenerateRoute: RouterConfig.onGenerateRoute,
      onUnknownRoute: RouterConfig.onUnknownRoute,
    );
  }
}
