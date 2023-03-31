import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../video/video_page.dart';
import '../publish/publish_page.dart';
import '../message/message_page.dart';
import '../profile/profile_page.dart';

class MainConfig {
  static List<Widget> pages = const [
    HomePage(),
    VideoPage(),
    PublishPage(),
    MessagePage(),
    ProfilePage()
  ];

  static List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
    const BottomNavigationBarItem(icon: Icon(Icons.video_call),label: "视频"),
    const BottomNavigationBarItem(icon: Icon(Icons.add),label: ""),
    const BottomNavigationBarItem(icon: Icon(Icons.message),label: "消息"),
    const BottomNavigationBarItem(icon: Icon(Icons.person),label: "我的"),
  ];


}
