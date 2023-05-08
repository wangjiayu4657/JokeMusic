import 'package:flutter/material.dart';
import 'package:jokemusic/tools/share/const_config.dart';

import '../../widgets/input.dart';
import '../../widgets/custom_button.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

///我的-意见反馈页
class FeedbackPage extends StatefulWidget {
  static const String routeName = "feedback";
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
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
            buildBodyQuestionSubmitButton()
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
        buildBodyQuestionTypeTitle(title: "请描述具体问题", fontWeight: FontWeight.bold),
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
    List<String> list = [
      "assets/images/sources/add_image.png",
      // "assets/images/sources/add_image.png",
      // "assets/images/sources/add_image.png",
      // "assets/images/sources/add_image.png",
      // "assets/images/sources/add_image.png",
      // "assets/images/sources/add_image.png",
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: list.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: width / 4,
        mainAxisSpacing: 10.px,
        crossAxisSpacing: 15.px
      ),
      itemBuilder: (context,idx) {
        return Image.asset(list[idx], fit: BoxFit.fill);
      }
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
        buildBodyQuestionTypeInput(isConnect: true, desc: "请输入您的联系方式, 如 qq:xxx, 微信:xxx, 邮箱:xxx, 手机号:xxx" )
      ],
    );
  }

  ///构建问题组件-标题
  Widget buildBodyQuestionTypeTitle({String? title, FontWeight? fontWeight}) {
    return Text(title ?? "",
      style: TextStyle(
        fontSize: 14.px,
        color: Colors.black87,
        fontWeight: fontWeight ?? FontWeight.normal
      )
    );
  }

  ///构建问题组件-输入框
  Widget buildBodyQuestionTypeInput({bool isConnect = false, String? desc}) {
    return Input(
      minLines: 4,
      maxLines: 8,
      placeholder: desc,
      borderType: BorderType.outlineBorder,
      borderColor: ColorExtension.lineColor,
      borderWidth: 1.px,
      contentPadding: EdgeInsets.all(12.px),
      valueChanged: (text) {
        print("text == $text");
      }
    );
  }

  ///构建内容组件-提交按钮
  Widget buildBodyQuestionSubmitButton()  {
    return SizedBox(
      width: double.infinity,
      height: 48.px,
      child: CustomButton(title: "提 交", onPressed: (){}),
    );
  }
}
