import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

class RefreshHeader extends ClassicHeader {
  const RefreshHeader({
    Key? key,
    String? dragText = "下拉刷新",
    String? armedText = "释放刷新",
    String? readyText = "释放刷新",
    String? processingText = "刷新中...",
    String? processedText = "刷新完成",
    String? noMoreText = "没有更多数据了",
    String? failedText = "请求失败了",
    String? messageText = "更新时间 %T"
  }) : super(
      key: key,
      dragText: dragText,
      armedText: armedText,
      readyText: readyText,
      processingText: processingText,
      processedText: processedText,
      noMoreText: noMoreText,
      failedText: failedText,
      messageText: messageText,
    );
}