import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';

///首页-用户推荐卡片
class HomeRecommendCard extends StatelessWidget {
  const HomeRecommendCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _userRecommended();
  }

  ///推荐用户
  Widget _userRecommended() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.px,
          color: ColorExtension.bgColor,
          alignment: Alignment.centerLeft ,
          padding: EdgeInsets.only(top: 10.px,left: 15.px),
          child: const Text("用户推荐", style: TextStyle(color: Colors.black38))
        ),
        Container(
          height: 180.px,
          color: ColorExtension.bgColor,
          padding: EdgeInsets.only(top: 0.px, left:10.px, bottom: 10.px ,right: 10.px),
          child: _userRecommendedGrid(),
        ),
      ],
    );
  }

  ///推荐用户-列表
  Widget _userRecommendedGrid() {
    return GridView.builder(
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,idx) => _userRecommendedGridItem(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1.3)
    );
  }

  ///推荐用户-列表-item
  Widget _userRecommendedGridItem() {
    return Card(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 2.px),
          CircleAvatar(child: Image.asset("assets/images/placeholder.png")),
          Text("明天会更好", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14.px)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("发表 148", style: TextStyle(fontSize: 12.px, color: Colors.black26)),
                Text("粉丝 48", style: TextStyle(fontSize: 12.px, color: Colors.black26)),
              ]),
          CustomButton(title: "+关注", height: 30.px,style: TextStyle(fontSize: 14.px), onPressed: (){}),
          SizedBox(height: 2.px),
        ],
      ),
    );
  }
}
