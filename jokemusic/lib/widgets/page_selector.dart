import 'package:flutter/material.dart';

class PageSelectorItem {
  PageSelectorItem({
    this.count = 0,
    this.title = ""
  });

  final int count;
  final String title;
}

class PageSelector extends StatefulWidget {
  const PageSelector({
    Key? key,
    required this.tabs,
    required this.children,
    this.bodyHeight = double.infinity,
    this.headerWidth = double.infinity,
    this.headerHeight = 48,
    this.isScrollable = true,
    this.padding,
    this.headerColor = Colors.white,
    this.indicatorColor,
    this.indicatorWeight = 2,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorSize,
    this.dividerColor,
    this.labelColor,
    this.labelStyle,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.labelPadding,
    this.onTap
  }) : assert(tabs.length == children.length,
       "tabs中的widget个数必须与pages中的widget个数一致"
       ),
       super(key: key);

  final List<Widget> tabs;
  final List<Widget> children;
  final double bodyHeight;
  final double? headerWidth;
  final double? headerHeight;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final Color? headerColor;
  final Color? indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final Decoration? indicator;
  final bool automaticIndicatorColorAdjustment;
  final TabBarIndicatorSize? indicatorSize;
  final Color? dividerColor;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final Color? unselectedLabelColor;
  final TextStyle? unselectedLabelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final ValueChanged? onTap;

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> with SingleTickerProviderStateMixin {
  late final _tabCtrl = TabController(length: widget.tabs.length, vsync: this);

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(useMaterial3: true),
      home: SizedBox(
        width: double.infinity,
        height: widget.bodyHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: widget.headerHeight,
              color: widget.headerColor,
              child: _tabBarTop()
            ),
            Expanded(child: _tabBarView()),
          ],
        ),
      ),
    );
  }

  _tabBarTop() => TabBar(
    onTap: widget.onTap,
    padding: widget.padding,
    isScrollable: widget.isScrollable,
    indicator: widget.indicator,
    indicatorColor: widget.indicatorColor,
    indicatorWeight: widget.indicatorWeight,
    indicatorPadding: widget.indicatorPadding,
    indicatorSize: widget.indicatorSize,
    dividerColor: widget.dividerColor,
    labelPadding: widget.labelPadding,
    labelColor: widget.labelColor,
    labelStyle: widget.labelStyle,
    unselectedLabelColor: widget.unselectedLabelColor,
    unselectedLabelStyle: widget.unselectedLabelStyle,
    automaticIndicatorColorAdjustment: widget.automaticIndicatorColorAdjustment,
    controller: _tabCtrl,
    tabs: widget.tabs
  );

  _tabBarView() => TabBarView(
    controller: _tabCtrl,
    children: widget.children
  );
}
