import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../common/no_data_prompt.dart';
import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import 'controllers/photo_browser_controller.dart';

///查看大图
class PhotoBrowserPage extends GetView<PhotoBrowserController> {
  static const routeName = "/profile/feedback/photo_browser";

  const PhotoBrowserPage({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.loadingBuilder,
  }) : super(key: key);

  final Axis scrollDirection;
  final LoadingBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.images?.isEmpty == true ?
      const NoDataPrompt(placeholderText: "") :
      buildPhotoBrowser(children: [
        //图片浏览项
        buildPhotoBrowserGalleryPreView(),
        //图片标题
        buildPhotoBrowserTitle()
      ])
    );
  }

  ///构建图片浏览页组件
  Widget buildPhotoBrowser({required List<Widget> children}) {
    return InkWell(
      onTap: Get.back,
      child: Container(
        constraints: BoxConstraints.expand(height: height),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: children,
        ),
      ),
    );
  }

  ///构建图片浏览页-标题组件
  Widget buildPhotoBrowserTitle() {
    return Padding(
      padding: EdgeInsets.all(20.px),
      child: GetBuilder<PhotoBrowserController>(builder: (logic) {
        return Text("Image ${logic.index + 1}",
            style: TextStyle(color: Colors.white, fontSize: 17.px)
        );
      }) // ,
    );
  }

  ///构建图片浏览页-预览组件
  Widget buildPhotoBrowserGalleryPreView() {
    return GetBuilder<PhotoBrowserController>(builder: (logic) {
      return PhotoViewGallery.builder(
        wantKeepAlive: true,
        itemCount: controller.images?.length,
        customSize: Size(width - 10.px, double.infinity),
        scrollPhysics: const BouncingScrollPhysics(),
        builder: buildPhotoBrowserGalleryPreViewItem,
        loadingBuilder: loadingBuilder ??buildPhotoBrowserGalleryPreViewLoading,
        pageController: controller.pageCtrl,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        onPageChanged: controller.changeSelectedIndex
      );
    });
  }

  ///构建图片浏览页-预览item组件
  PhotoViewGalleryPageOptions buildPhotoBrowserGalleryPreViewItem(BuildContext context, int index) {
    final AssetEntity entity = controller.images![controller.index];
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetEntityImageProvider(entity, isOriginal: false),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered,
      heroAttributes: PhotoViewHeroAttributes(tag: entity),
    );
  }

  ///构建图片浏览页-loading组件
  Widget buildPhotoBrowserGalleryPreViewLoading(BuildContext context, ImageChunkEvent? event) {
    return Center(
      child: SizedBox(
        width: 20.px,
        height: 20.px,
        child: CircularProgressIndicator(
          value: event == null ? 0 : event.cumulativeBytesLoaded /
              (event.expectedTotalBytes ?? event.cumulativeBytesLoaded),
        ),
      ),
    );
  }
}
