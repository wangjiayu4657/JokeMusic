import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../common/input.dart';
import '../../common/custom_button.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

// import '../profile/photo_browser_page.dart';
import '../profile/views/picker_method.dart';
import '../profile/controllers/feedback_controller.dart';


///我的-意见反馈页
class FeedbackPage extends GetView<FeedbackController> {
  static const String routeName = "/profile/feedback";
  const FeedbackPage({Key? key}) : super(key: key);


  // double _sizeHeight = 0;
  // //监听是否获取焦点
  // final _connectFocusNode = FocusNode();
  // //为了获取目标组件位置
  // final GlobalKey _targetWidgetKey = GlobalKey();
  // final ScrollController _scrollController = ScrollController();
  // List<AssetEntity> _images = <AssetEntity>[];
  //
  // ///处理选择的图片
  // Future<void> handlerImageSelected(PickerMethod pickerMethod) async {
  //   final List<AssetEntity>? result = await pickerMethod.method(context, _images);
  //   if (result == null) return;
  //   _images = result.toList();
  //   if (mounted) setState(() { });
  // }
  //
  // @override
  // void initState() {
  //   //初始化, 监听键盘弹出
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }
  //
  // @override
  // void didChangeMetrics() {
  //   //更新SizeBox的高度,让SingleChildScrollView可以滚动
  //   setState(() => _sizeHeight = keyboardHeight + 30);
  //
  //   if (keyboardHeight <= 0) return;
  //
  //   // 获取目标位置的坐标
  //   RenderBox? renderBox = _targetWidgetKey.currentContext?.findRenderObject() as RenderBox?;
  //   if (renderBox == null) return;
  //
  //   //目标位置距离顶部的距离, 转换为全局坐标
  //   final topOffsetY = renderBox.localToGlobal(Offset(0, renderBox.size.height)).dy;
  //
  //   //获取要滚动的距离, 即被软键盘挡住的那段距离
  //   final offsetY = keyboardHeight - (height - topOffsetY) + 30.px;
  //
  //   // 滑动到指定位置
  //   if (_connectFocusNode.hasFocus) {
  //     _scrollController.animateTo(
  //       offsetY,
  //       duration: const Duration(milliseconds: 250),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  //
  //   super.didChangeMetrics();
  // }
  //
  //
  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("意见反馈")),
        body: buildBody(),
      ),
    );
  }

  ///构建内容组件
  Widget buildBody() {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 20.px),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            buildBodyQuestionDesc(),
            SizedBox(height: 15.px),
            buildBodyQuestionImage(),
            SizedBox(height: 15.px),
            buildBodyQuestionConnect(),
            SizedBox(height: 20.px),
            buildBodyQuestionSubmitButton(),
            GetBuilder<FeedbackController>(builder: (logic) {
              print("sizeHeight == ${logic.sizeHeight}");
              return SizedBox(height: logic.sizeHeight);
            }) //动态调整高度,让SingleChildScrollView可以滚动
          ],
        ),
      ),
    );
  }

  ///构建内容组件-问题描述
  Widget buildBodyQuestionDesc() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBodyQuestionTypeTitle(title: "请描述具体问题"),
        SizedBox(height: 10.px),
        buildBodyQuestionTypeInput(isConnect: false, desc: "请详细描述您遇到的问题,方便我们排查问题...")
      ],
    );
  }

  ///构建内容组件-图片补充
  Widget buildBodyQuestionImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBodyQuestionTypeTitle(title: "图片补充: (相关图片能帮助我们快速定位问题)"),
        SizedBox(height: 15.px),
        buildBodyQuestionImageList()
      ],
    );
  }

  ///构建内容组件-图片补充-图片列表
  Widget buildBodyQuestionImageList() {
    return GetBuilder<FeedbackController>(builder: (logic) {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: logic.images.length + 1,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: width / 4,
          mainAxisSpacing: 10.px,
          crossAxisSpacing: 15.px
        ),
        itemBuilder: (context, idx) {
          return InkWell(
            onTap: () =>controller.handlerImageSelected(PickerMethod.image(maxCount: 6)),
            child: buildBodyQuestionImageListItem(idx)
          );
        }
      );
    });
  }

  ///构建gridView的item
  Widget buildBodyQuestionImageListItem(int idx) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildSelectedImage(idx),
        Positioned(top: -10.px, right: -10.px, child: buildGridViewItemDelButton(idx)),
      ],
    );
  }

  ///构建gridView的item-删除按钮
  Widget buildGridViewItemDelButton(int idx) {
    return (controller.images.isEmpty || idx == controller.images.length) ?
    const SizedBox() :
    IconButton(
      onPressed: () => controller.removeSelectedImage(idx),
      icon: Image.asset("assets/images/sources/del_image.png", width: 20.px, height: 20.px)
    );
  }

  ///构建并显示选中的图片
  Widget buildSelectedImage(int idx) {
    return (controller.images.isEmpty || idx == controller.images.length) ?
    Image.asset("assets/images/sources/add_image.png") :
    InkWell(
      onTap: () => controller.openPhotoBrowser(idx),
      child: Hero(
        tag: controller.images[idx],
        child: AssetEntityImage(controller.images[idx], isOriginal: false, fit: BoxFit.cover)
      ),
    );
  }

  ///构建内容组件-联系方式
  Widget buildBodyQuestionConnect() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBodyQuestionTypeTitle(title: '联系方式:'),
        SizedBox(height: 10.px),
        buildBodyQuestionTypeInput(isConnect: true, desc: "请输入您的联系方式, 如 qq:xxx, 微信:xxx, 邮箱:xxx, 手机号:xxx")
      ],
    );
  }

  ///构建问题组件-标题
  Widget buildBodyQuestionTypeTitle({String? title}) {
    return Text(title ?? "",
      style: TextStyle(
        fontSize: 14.px,
        color: Colors.black87,
        fontWeight: FontWeight.normal
      )
    );
  }

  ///构建问题组件-输入框
  Widget buildBodyQuestionTypeInput({bool isConnect = false, String? desc}) {
    return Input(
      minLines: 4,
      maxLines: 8,
      placeholder: desc,
      focusNode: isConnect ? controller.connectFocusNode : null,
      borderType: BorderType.outlineBorder,
      borderColor: ColorExtension.lineColor,
      borderWidth: 1.px,
      contentPadding: EdgeInsets.all(12.px),
      valueChanged: (text) {
        debugPrint("text == $text");
      }
    );
  }

  ///构建内容组件-提交按钮
  Widget buildBodyQuestionSubmitButton() {
    return SizedBox(
      key: controller.targetWidgetKey,
      width: double.infinity,
      height: 48.px,
      child: CustomButton(title: "提 交", onPressed: () {

      }),
    );
  }
}
