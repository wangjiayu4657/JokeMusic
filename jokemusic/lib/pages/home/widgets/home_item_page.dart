import 'package:flutter/material.dart';
import 'package:jokemusic/pages/home/widgets/home_recommend_card.dart';

import '../../../widgets/video_item.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/no_data_prompt.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';


enum HomeItemType {
  ///关注
  focus,
  ///推荐
  recommend,
  ///新鲜
  refresh,
  ///纯文
  text,
  ///趣图
  picture
}

//首页 - 关注
class HomeItemPage extends StatefulWidget {
  const HomeItemPage({
    Key? key,
    this.homeItemType = HomeItemType.focus
  }) : super(key: key);

  final HomeItemType homeItemType;

  @override
  State<HomeItemPage> createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage> {

  ItemType get itemType {
    if(widget.homeItemType.index == 3) {
      return ItemType.text;
    } else if(widget.homeItemType.index == 4){
      return ItemType.picture;
    } else {
      return ItemType.video;
    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _recommendCard(),
        _focusList(false)
      ],
    );
  }

  ///用户推荐
  Widget _recommendCard() {
    return widget.homeItemType.index == 0 ?
    const SliverToBoxAdapter(child: HomeRecommendCard()) :
    const SliverToBoxAdapter(child: SizedBox());
  }

  ///关注列表
  Widget _focusList(bool isEmpty) {
    return isEmpty ?
    const SliverFillRemaining(
      hasScrollBody: false,
      child: NoDataPrompt()
    ) :
    SliverList.separated(
      itemCount: 20,
      itemBuilder: (context, idx) => _focusListItem(),
      separatorBuilder: (context, idx) => Divider(color:ColorExtension.lineColor,  height: 24.px, thickness: 8.px)
    );
  }

  ///关注列表-item
  Widget _focusListItem() {
    return VideoItem(
      itemType: itemType,
      actions: [
        InkWell(
          onTap: (){},
          child: const Text("+ 关注", style: TextStyle(color: Colors.orangeAccent))
        ),
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_horiz, color: Colors.black45)
        ),
      ]
    );
  }
}
