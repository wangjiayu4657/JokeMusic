import 'package:flutter/material.dart';

import '../../widgets/vertical_item.dart';
import '../../widgets/navigation_item_bar.dart';
import '../../tools/extension/int_extension.dart';

///我的-审核结果页
class AuditResultPage extends StatefulWidget {
  static const String routeName = "/audit_result";
  const AuditResultPage({Key? key}) : super(key: key);

  @override
  State<AuditResultPage> createState() => _AuditResultPageState();
}

class _AuditResultPageState extends State<AuditResultPage> {
  int _curIdx = 0;
  late final List _source = [];
  late final PageController _pageController = PageController(initialPage: _curIdx);

  void onPageChanged(idx) {
    setState(() {
      _curIdx = idx;
      _pageController.jumpToPage(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("审核结果")),
      body: Column(
        children: [
          buildHeader(),
          Expanded(child: buildContent())
        ],
      ),
    );
  }

  ///构建内容组件-头部组件
  Widget buildHeader()  {
    return NavigationItemBar(
      items: const ['审核中','审核失败'],
      currentIndex: _curIdx,
      isShowBottomLine: true,
      callBack: onPageChanged,
    );
  }

  ///构建内容组件
  Widget buildContent() {
    return PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: [
        buildContentUnderReview(),
        buildContentAuditFailure()
      ],
    );
  }

  ///构建内容-审核中组件
  Widget buildContentUnderReview() {
    return buildAuditResultList(imgName: "profile_auditing",title: "审核中");
  }

  ///构建内容-审核失败组件
  Widget buildContentAuditFailure() {
    return buildAuditResultList(imgName: "profile_audit_failure",title: "审核失败");
  }

  ///构建内容-审核结果列表组件
  Widget buildAuditResultList({String? imgName, String? title}) {
    final msg = title?.contains("审核中") == true ? "暂无审核中的数据" : "暂无审核失败的数据";
    return _source.isEmpty ?
      buildContentNoDataTip(msg) :
      ListView.builder(
        itemCount: _source.length,
        itemBuilder: (context,idx) {
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
