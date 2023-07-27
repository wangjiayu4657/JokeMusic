
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoBrowserController extends GetxController {
  late int index;
  late List<AssetEntity>? images;
  late final pageCtrl = PageController();

  @override
  void onInit() {
    index = Get.arguments["index"] as int;
    images = Get.arguments["images"] as List<AssetEntity>;

    print("index === $index");
    update();
    super.onInit();
  }

  @override
  void onClose() {
    pageCtrl.dispose();
    super.onClose();
  }

  void changeSelectedIndex(int idx) {
    index = idx;
    update();
  }
}

class PhotoBrowserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoBrowserController>(() => PhotoBrowserController());
  }
}