import 'package:flutter/material.dart';
import 'package:jokemusic/tools/extension/int_extension.dart';

import 'widgets/home_search.dart';
import 'widgets/home_focus.dart';
import 'widgets/home_recommend.dart';
import 'widgets/home_fresh.dart';
import 'widgets/home_text.dart';
import 'widgets/home_picture.dart';
import '../../widgets/navigation_item_bar.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final PageController _pageController = PageController(initialPage: _currentIndex);

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
          items: const ["关注","推荐","新鲜","纯文","趣图"],
          currentIndex: _currentIndex,
          isShowBottomLine: false,
          bottomLineColor: Colors.redAccent,
          callBack: onPageChanged
        ),
        actions: [
          navigationBarItemSearch()
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: const [
        HomeFocus(),
        HomeRecommend(),
        HomeFresh(),
        HomeText(),
        HomePicture(),
      ],
    );
  }

  Widget navigationBarItemSearch() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, HomeSearch.routeName);
      },
      child: Container(
        width: 50.px,
        height: 40.px,
        padding: EdgeInsets.only(right: 20.px,bottom: 5.px),
        child: Image.asset("assets/images/sources/search.png"),
      )
    );
  }
}
