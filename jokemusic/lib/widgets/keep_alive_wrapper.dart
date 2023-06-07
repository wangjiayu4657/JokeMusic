import 'package:flutter/material.dart';

///pageView 页面缓存
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child
  }) : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
    if(oldWidget.keepAlive != widget.keepAlive) updateKeepAlive();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
