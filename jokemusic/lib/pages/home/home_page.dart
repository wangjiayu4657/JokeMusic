import 'package:flutter/material.dart';

import 'widgets/home_search.dart';
import 'widgets/home_navigation_bar.dart';
import 'widgets/home_focus.dart';
import 'widgets/home_recommend.dart';
import 'widgets/home_fresh.dart';
import 'widgets/home_text.dart';
import 'widgets/home_picture.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final PageController _pageController = PageController(initialPage: _currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HomeNavigationBar(
          currentIndex: _currentIndex,
          callBack: (idx) => setState(() => _currentIndex = idx)
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return PageView(
      controller: _pageController,
      onPageChanged: (idx) => setState(() => _currentIndex = idx),
      children: const [
        HomeFocus(),
        HomeRecommend(),
        HomeFresh(),
        HomeText(),
        HomePicture(),
        HomeSearch()
      ],
    );
  }
}
