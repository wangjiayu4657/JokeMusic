import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'pages/main/main_page.dart';
import 'services/routes/router_config.dart' as config;
import 'services/theme/theme_config.dart';
import 'tools/share/device_manager.dart';
import 'common/custom/custom_toast_widget.dart';
import 'common/custom/custom_loading_widget.dart';

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
      getPages: config.RouterConfig.routePages,
      onUnknownRoute: config.RouterConfig.onUnknownRoute,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(
        toastBuilder: (String msg) => CustomToastWidget(msg: msg),
        loadingBuilder: (String msg) => CustomLoadingWidget(msg: msg),
      ),
    );
  }
}
