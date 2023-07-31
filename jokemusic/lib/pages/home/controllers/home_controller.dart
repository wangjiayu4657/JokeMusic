import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/navigation_item_bar.dart';
import '../widgets/home_item_page.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late int currentIndex = 0;
  late final tabCtrl = TabController(length: items.length, vsync: this);

  final List<BarItem> items = const [
    BarItem(title: "关注"),
    BarItem(title: "推荐"),
    BarItem(title: "新鲜"),
    BarItem(title: "纯文"),
    BarItem(title: "趣图")
  ];

  final List<HomeItemType> itemTypes = const [
    HomeItemType.focus,
    HomeItemType.recommend,
    HomeItemType.refresh,
    HomeItemType.text,
    HomeItemType.picture
  ];

  void onPageChanged(int idx){
    currentIndex = idx;
    update();
  }

  @override
  void dispose() {
    tabCtrl.dispose();
    super.dispose();
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
