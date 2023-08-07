import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jokemusic/pages/home/controllers/home_item_controller.dart';
import 'package:jokemusic/pages/home/models/video_item.dart';

import '../../../common/video_item.dart';
import '../../../common/no_data_prompt.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../pages/home/widgets/home_recommend_card.dart';

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
class HomeItemPage extends GetView<HomeItemController> {
  const HomeItemPage({
    Key? key,
    this.homeItemType = HomeItemType.focus
  }) : super(key: key);

  final HomeItemType homeItemType;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeItemController>(() => HomeItemController());

    return CustomScrollView(
      slivers: [
        //用户推荐
        _recommendCard(),

        //关注
        _focusList(false)
      ],
    );
  }

  ///用户推荐
  Widget _recommendCard() {
    return homeItemType.index == 0
        ? const SliverToBoxAdapter(child: HomeRecommendCard())
        : const SliverToBoxAdapter(child: SizedBox());
  }

  ///关注列表
  Widget _focusList(bool isEmpty) {
    return isEmpty
      ? const SliverFillRemaining(hasScrollBody: false, child: NoDataPrompt())
      : GetBuilder<HomeItemController>(builder: (logic) {
          return SliverList.separated(
            itemCount: logic.items.length,
            itemBuilder: (context, idx) => _focusListItem(item: logic.items[idx]),
            separatorBuilder: (context, idx) {
              return Divider(
                color: ColorExtension.lineColor,
                height: 24.px,
                thickness: 8.px
              );
            }
          );
        }
      );
  }

  ///关注列表-item
  Widget _focusListItem({VideoItem? item}) {
    return VideoItemView(
      title: item?.user?.nickName,
      subTitle: item?.user?.signature,
      avatar: item?.user?.avatar,
      text: item?.joke?.content,
      itemType: controller.itemType,
      imgUrl: item?.joke?.imageUrl,
      videoUrl: item?.joke?.videoUrl,
      actions: [
        InkWell(
          onTap: () {},
          child: const Text("+ 关注", style: TextStyle(color: Colors.orangeAccent))
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, color: Colors.black45)
        ),
      ]
    );
  }
}
