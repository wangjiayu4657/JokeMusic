import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:jokemusic/common/custom/custom_single_child_scroll_view.dart';
import 'package:jokemusic/tools/refresh/refresh_footer.dart';
import 'package:jokemusic/tools/refresh/refresh_header.dart';

import '../../../common/video_item.dart';
import '../../../common/no_data_prompt.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../pages/home/models/video_item.dart';
import '../../../pages/home/widgets/home_recommend_card.dart';
import '../../../pages/home/controllers/home_item_controller.dart';

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
  HomeItemPage({
    Key? key,
    this.homeItemType = HomeItemType.focus
  }) : super(key: key);

  final HomeItemType homeItemType;
  late final ctrl = Get.put<HomeItemController>(HomeItemController(homeItemType: homeItemType), tag: "$homeItemType");

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const RefreshHeader(),
      footer: const RefreshFooter(),
      onRefresh: ctrl.onRefresh,
      onLoad: ctrl.onLoad,
      refreshOnStart: true,
      controller: ctrl.refreshCtrl,
      child: CustomScrollView(
        slivers: [
          //用户推荐
          _recommendCard(),

          //列表
          _listView()
        ],
      ),
    );
  }

  ///用户推荐
  Widget _recommendCard() {
    return homeItemType.index == 0
        ? const SliverToBoxAdapter(child: HomeRecommendCard())
        : const SliverToBoxAdapter(child: SizedBox());
  }

  ///关注列表
  Widget _listView() {
    return GetBuilder<HomeItemController>(
        id: '$homeItemType',
        tag: '$homeItemType',
        builder: (logic) {
          return logic.items.isEmpty
            ? logic.isLoading
              ? const SliverFillRemaining(child: SizedBox())
              : const SliverFillRemaining(hasScrollBody: false, child: NoDataPrompt())
            : SliverList.separated(
              itemCount: logic.items.length,
              itemBuilder: (context, idx) => _focusListItem(item: logic.items[idx]),
              separatorBuilder: (context, idx) {
                return Divider(
                  color: ColorExtension.lineColor,
                  height: 24.px,
                  thickness: 8.px
                );
              });
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
      itemType: item?.joke?.type,
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
