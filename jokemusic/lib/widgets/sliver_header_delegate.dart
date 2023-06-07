import 'package:flutter/material.dart';

typedef SliverHeaderBuilder = Widget Function (BuildContext context, double shrinkOffset, bool overlapsContent);

///SliverPersistentHeader 的子类, 用户CustomScrollView中列表组头悬停效果
class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// child 为 header
  SliverHeaderDelegate({
    this.minHeight = 0,
    required this.maxHeight,
    required Widget child
  }) : builder = ((a, b, c) => child),
       assert(minHeight <= maxHeight && minHeight >= 0);

  ///最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child
  }) : minHeight = height,
       maxHeight = height,
       builder = ((a,b,c) => child);

  ///需要自定义builder时使用
  SliverHeaderDelegate.builder({
    this.minHeight = 0,
    required this.maxHeight,
    required this.builder
  });

  ///最小高度
  final double minHeight;
  ///最大高度
  final double maxHeight;
  ///子组件构建器
  final SliverHeaderBuilder builder;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget child = builder(context, shrinkOffset, overlapsContent);

    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert((){
      if(child.key != null) debugPrint('${child.key}: shrink: $shrinkOffset, overlaps: $overlapsContent');
      return true;
    }());

    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minHeight || oldDelegate.maxExtent != maxHeight;
  }
}