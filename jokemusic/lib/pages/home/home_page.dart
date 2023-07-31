import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/routes/route_name_config.dart';
import '../../common/keep_alive_wrapper.dart';
import '../../tools/extension/int_extension.dart';
import '../../pages/home/widgets/home_item_page.dart';
import '../../pages/home/controllers/home_controller.dart';


class HomePage extends GetView<HomeController>  {
  static const String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(() => HomeController());

    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<HomeController>(builder: (logic) {
          return TabBar(
            controller: logic.tabCtrl,
            indicatorColor: Colors.red,
            indicatorPadding: EdgeInsets.only(bottom: 2.px),
            labelColor: Colors.red,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.px),
            labelStyle: TextStyle(fontSize: 18.px, fontWeight: FontWeight.w600),
            unselectedLabelColor: Colors.black54,
            unselectedLabelStyle: TextStyle(fontSize: 18.px, fontWeight: FontWeight.w600),
            tabs: logic.items.map((e) => Tab(text: e.title)).toList()
          );
        }),
        actions: [ navigationBarItemSearch() ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: TabBarView(
        controller: controller.tabCtrl,
        children: controller.itemTypes.map((e) => KeepAliveWrapper(child: HomeItemPage(homeItemType: e))).toList()
      ),
    );
  }

  Widget navigationBarItemSearch() {
    return InkWell(
      onTap: () => Get.toNamed(RouteName.search),
      child: Container(
        width: 50.px,
        height: 30.px,
        padding: EdgeInsets.only(right: 20.px),
        child: Image.asset("assets/images/sources/search.png"),
      )
    );
  }
}
