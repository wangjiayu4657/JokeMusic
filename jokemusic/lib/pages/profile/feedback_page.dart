import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../common/input.dart';
import '../../common/custom_button.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../profile/views/picker_method.dart';
import '../profile/controllers/feedback_controller.dart';


///我的-意见反馈页
class FeedbackPage extends GetView<FeedbackController> {
  static const String routeName = "/profile/feedback";
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildFeedbackPage(children: [

      //问题描述
      _questionDescView(children: [
        //问题描述标题
        _questionTypeTitle(title: "请描述具体问题"),
        //问题描述输入内容框
        _questionTypeInput(isConnect: false, desc: "请详细描述您遇到的问题,方便我们排查问题...")
      ]),

      //图片补充
      _questionImageView(children: [
        //图片补充标题
        _questionTypeTitle(title: "图片补充: (相关图片能帮助我们快速定位问题)"),
        //图片补充内容列表
        _questionImageListView(itemBuilder: (idx){
          return [
            //预览图片
            _previewImage(idx),
            //删除按钮
            _deleteButton(idx),
          ];
        })
      ]),

      //联系方式
      _questionConnectView(children: [
        //联系方式标题
        _questionTypeTitle(title: '联系方式:'),
        //联系方式输入内容框
        _questionTypeInput(isConnect: true, desc: "请输入您的联系方式, 如 qq:xxx, 微信:xxx, 邮箱:xxx, 手机号:xxx")
      ]),

      //提交按钮
      _submitButton(),

      //底部动态高度(为了让输入框输入多行文字时不被键盘遮挡)
      GetBuilder<FeedbackController>(builder: (logic) {
        return SizedBox(height: logic.sizeHeight);
      }) //动态调整高度,让SingleChildScrollView可以滚动
    ]);
  }

  Widget _buildFeedbackPage({required List<Widget> children}){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("意见反馈")),
        body: buildBody(children: children),
      ),
    );
  }

  ///构建内容组件
  Widget buildBody({required List<Widget> children}) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 15.px),
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 20.px),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(children: children),
      ),
    );
  }

  ///构建内容组件-问题描述
  Widget _questionDescView({required List<Widget> children}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ///构建内容组件-图片补充
  Widget _questionImageView({required List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.only(top: 15.px, bottom: 15.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  ///构建内容组件-图片补充-图片列表
  Widget _questionImageListView({required List<Widget> Function(int idx) itemBuilder}) {
    return GetBuilder<FeedbackController>(builder: (logic) {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.px),
        itemCount: logic.images.length + 1,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: width / 4,
          mainAxisSpacing: 10.px,
          crossAxisSpacing: 15.px
        ),
        itemBuilder: (context, idx) {
          return InkWell(
            onTap: () => controller.handlerImageSelected(PickerMethod.image(maxCount: 6)),
            child: Stack(
              fit: StackFit.expand,
              children: itemBuilder(idx),
            )
          );
        }
      );
    });
  }

  ///构建gridView的item-删除按钮
  Widget _deleteButton(int idx) {
    return (controller.images.isEmpty || idx == controller.images.length) ?
    const SizedBox() :
    Positioned(
      top: -10.px,
      right: -10.px,
      child: IconButton(
        onPressed: () => controller.removeSelectedImage(idx),
        icon: Image.asset("assets/images/sources/del_image.png", width: 20.px, height: 20.px)
      )
    );
  }

  ///显示预览图片
  Widget _previewImage(int idx) {
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
  Widget _questionConnectView({required List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.only(bottom:20.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  ///构建问题组件-标题
  Widget _questionTypeTitle({String? title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.px),
      child: Text(title ?? "",
        style: TextStyle(
          fontSize: 14.px,
          color: Colors.black87,
          fontWeight: FontWeight.normal
        )
      ),
    );
  }

  ///构建问题组件-输入框
  Widget _questionTypeInput({bool isConnect = false, String? desc}) {
    return Input(
      minLines: 4,
      maxLines: 8,
      placeholder: desc,
      autofocus: false,
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
  Widget _submitButton() {
    return SizedBox(
      key: controller.targetWidgetKey,
      width: double.infinity,
      height: 48.px,
      child: CustomButton(
        title: "提 交",
        style: const TextStyle(color: Colors.white),
        onPressed: () { }
      ),
    );
  }
}
