import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/audit_result_controller.dart';
import '../../common/vertical_item.dart';
import '../../common/navigation_item_bar.dart';
import '../../tools/extension/int_extension.dart';

///我的-审核结果页
class AuditResultPage extends GetView<AuditResultController> {
  static const String routeName = "/audit_result";
  const AuditResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("审核结果")),
      body: _buildBody(children: [
        //头部
        _bodyHeader(),

        //内容
        _bodyContent(children: [

          //审核中
          buildContentUnderReview(),

          //审核失败
          buildContentAuditFailure()
        ])
      ]),
    );
  }

  ///构建内容
  Widget _buildBody({required List<Widget> children}) {
    return Column(children: children);
  }

  ///构建内容组件-头部组件
  Widget _bodyHeader() {
    return GetBuilder<AuditResultController>(builder: (logic) {
      return NavigationItemBar(
        items: const [BarItem(title: "审核中"), BarItem(title: "审核失败")],
        currentIndex: logic.curIdx,
        isShowBottomLine: true,
        callBack: logic.onPageChanged,
      );
    });
  }

  ///构建内容组件
  Widget _bodyContent({required List<Widget> children}) {
    return GetBuilder<AuditResultController>(builder: (logic) {
      return Expanded(
        child: PageView(
          controller: logic.pageController,
          onPageChanged: logic.onPageChanged,
          children: children,
        ),
      );
    });
  }

  ///构建内容-审核中组件
  Widget buildContentUnderReview() {
    return buildAuditResultList(imgName: "profile_auditing", title: "审核中");
  }

  ///构建内容-审核失败组件
  Widget buildContentAuditFailure() {
    return buildAuditResultList(imgName: "profile_audit_failure", title: "审核失败");
  }

  ///构建内容-审核结果列表组件
  Widget buildAuditResultList({String? imgName, String? title}) {
    final msg = title?.contains("审核中") == true ? "暂无审核中的数据" : "暂无审核失败的数据";
    return controller.source.isEmpty ?
    buildContentNoDataTip(msg) :
    ListView.builder(
      itemCount: controller.source.length,
      itemBuilder: (context, idx) {
        return ListTile(
          leading: Image.asset("assets/images/sources/$imgName@3x.png", width: 20.px),
          title: Text(title ?? ""),
          subtitle: Text(DateTime.now().toString()),
        );
      }
    );
  }

  ///构建内容-无数据时提示组件
  Widget buildContentNoDataTip(String msg) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.px),
      child: Center(
        child: VerticalItem(
          title: msg,
          icon: Image.asset("assets/images/sources/profile_post_tip.png"),
        ),
      ),
    );
  }
}
