import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../profile/views/picker_method.dart';
import '../../../tools/share/const_config.dart';
import '../../../tools/extension/int_extension.dart';
import '../photo_browser_page.dart';

class FeedbackController extends GetxController {
  double sizeHeight = 0;
  //监听是否获取焦点
  final connectFocusNode = Get.focusScope;
  //为了获取目标组件位置
  final GlobalKey targetWidgetKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  List<AssetEntity> images = <AssetEntity>[];

  ///处理选择的图片
  Future<void> handlerImageSelected(PickerMethod pickerMethod) async {
    final List<AssetEntity>? result = await pickerMethod.method(Get.context!, images);
    if (result == null) return;
    images = result.toList();
    update();
  }

  void didChangeMetrics() {
    //更新SizeBox的高度,让SingleChildScrollView可以滚动
     sizeHeight = keyboardHeight + 30;

    if (keyboardHeight <= 0) return;

    // 获取目标位置的坐标
    RenderBox? renderBox = targetWidgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    //目标位置距离顶部的距离, 转换为全局坐标
    final topOffsetY = renderBox.localToGlobal(Offset(0, renderBox.size.height)).dy;

    //获取要滚动的距离, 即被软键盘挡住的那段距离
    final offsetY = keyboardHeight - (height - topOffsetY) + 30.px;

    // 滑动到指定位置
    if (connectFocusNode?.hasFocus == true) {
      scrollController.animateTo(
        offsetY,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }

    update();
  }

  ///删除已选择的图片
  void removeSelectedImage(int idx) {
    images.removeAt(idx);
    update();
  }

  ///打开图片浏览器
  void openPhotoBrowser(int idx) {
    Get.toNamed(PhotoBrowserPage.routeName, arguments: {
      'index':idx,
      'images':images
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }
}