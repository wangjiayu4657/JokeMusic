import 'package:flutter/material.dart';

import 'widgets/home_search.dart';
import '../../widgets/keep_alive_wrapper.dart';
import '../../widgets/navigation_item_bar.dart';
import '../../tools/extension/int_extension.dart';
import '../../pages/home/widgets/home_item_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final PageController _pageController = PageController(initialPage: _currentIndex);
  final List<BarItem> _items = const [
    BarItem(title: "关注"),
    BarItem(title: "推荐"),
    BarItem(title: "新鲜"),
    BarItem(title: "纯文"),
    BarItem(title: "趣图")
  ];

  void onPageChanged(int idx){
    setState(() {
      _currentIndex = idx;
      _pageController.jumpToPage(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NavigationItemBar(
          items: _items,
          isShowBottomLine: false,
          currentIndex: _currentIndex,
          bottomLineColor: Colors.redAccent,
          callBack: onPageChanged
        ),
        actions: [ navigationBarItemSearch() ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    const List<HomeItemType> itemTypes = [
      HomeItemType.focus,
      HomeItemType.recommend,
      HomeItemType.refresh,
      HomeItemType.text,
      HomeItemType.picture
    ];

    return PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: itemTypes.map((e) => KeepAliveWrapper(child: HomeItemPage(homeItemType: e))).toList(),
    );
  }

  Widget navigationBarItemSearch() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, HomeSearch.routeName);
      },
      child: Container(
        width: 50.px,
        height: 30.px,
        padding: EdgeInsets.only(right: 20.px,bottom: 12.px),
        child: Image.asset("assets/images/sources/search.png"),
      )
    );
  }
}
