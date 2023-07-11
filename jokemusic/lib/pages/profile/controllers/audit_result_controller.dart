import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuditResultController extends GetxController {
  int curIdx = 0;
  late final List source = [];
  late final PageController pageController = PageController(initialPage: curIdx);

  void onPageChanged(idx) {
    curIdx = idx;
    pageController.jumpToPage(idx);
    update();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class AuditResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuditResultController>(() => AuditResultController());
  }
}