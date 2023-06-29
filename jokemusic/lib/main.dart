import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'pages/main/main_page.dart';
import 'services/routes/router_config.dart' as config;
import 'services/theme/theme_config.dart';
import 'tools/share/device_manager.dart';
// import 'tools/share/provider_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceManager.deviceInfo();

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.normalTheme,
      darkTheme: ThemeConfig.darkTheme,
      initialRoute: MainPage.routeName,
      getPages: config.RouterConfigs.routePages,
      onUnknownRoute: config.RouterConfigs.onUnknownRoute,
    );
  }
}
