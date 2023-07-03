import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEditorController extends GetxController with GetSingleTickerProviderStateMixin {
  late int page = 0;
  late int subPage  = 0;
  late final pageCtrl = PageController();
  final List<String> tabs = <String>['作品', '喜欢', '评论', '收藏'];
  late final tabCtrl = TabController(length: tabs.length, vsync: this);

  void changeItem(int index) {
    page = index;
    subItemChanged(0);
  }

  void subItemChanged(int index){
    subPage = index;
    toTargetPage();
  }

  void pageChanged(int index){
    page = index ~/ 3;   //_page 取值: 0,1,2
    subPage = index % 3; //_subPage 取值: 0,1,2
    toTargetPage();
  }

  void toTargetPage(){
    int curIdx = subPage + page * 3;

    tabCtrl.animateTo(page);
    pageCtrl.jumpToPage(curIdx);

    update();
  }

  @override
  void onClose() {
    tabCtrl.dispose();
    pageCtrl.dispose();
    super.onClose();
  }
}

class UserEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserEditorController>(() => UserEditorController());
  }
}