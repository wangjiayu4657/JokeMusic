import 'package:flutter/material.dart';

//首页 - 搜索
class HomeSearch extends StatefulWidget {
  static const String routeName = "/home/search";
  const HomeSearch({Key? key}) : super(key: key);

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('搜索')),
      body: Container(color: Colors.white),
    );
  }
}
