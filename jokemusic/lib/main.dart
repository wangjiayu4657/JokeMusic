import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/main/main_page.dart';
import 'services/routes/router_config.dart' as config;
import 'services/theme/theme_config.dart';
import 'tools/share/device_manager.dart';
import 'tools/share/provider_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: ProviderService.providers,
      child: const MyApp()
    )
  );
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
      initialRoute: MainPage.routeName,
      onGenerateRoute: config.RouterConfig.onGenerateRoute,
      onUnknownRoute: config.RouterConfig.onUnknownRoute,
    );
  }
}
