
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class RefreshFooter extends ClassicFooter {
  const RefreshFooter({
    Key? key,
    String? dragText = "上拉加载",
    String? armedText = "释放加载",
    String? readyText = "释放加载",
    String? processingText = "加载中...",
    String? processedText = "加载完成",
    String? noMoreText = "没有更多数据了",
    String? failedText = "请求失败了",
    String? messageText = "更新时间 %T",
  }) : super( key: key,
      infiniteOffset: null,
      dragText: dragText,
      armedText: armedText,
      readyText: readyText,
      processingText: processingText,
      processedText: processedText,
      noMoreText: noMoreText,
      failedText: failedText,
      messageText: messageText
  );
}