import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';

///查看大图
class PhotoBrowserPage extends StatefulWidget {
  static const routeName = "/profile/feedback/photo_browser";

  PhotoBrowserPage({
    Key? key,
    required this.images,
    this.initialIndex = 0,
    this.minScale,
    this.maxScale,
    this.scrollDirection = Axis.horizontal,
    this.loadingBuilder,
    this.backgroundDecoration,
  }) : pageController = PageController(initialPage: initialIndex),
       super(key: key);

  final int initialIndex;
  final dynamic minScale;
  final dynamic maxScale;
  final List<AssetEntity> images;
  final Axis scrollDirection;
  final PageController pageController;
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;

  @override
  State<PhotoBrowserPage> createState() => _PhotoBrowserPageState();
}

class _PhotoBrowserPageState extends State<PhotoBrowserPage> {
  late int idx = widget.initialIndex;

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildPhotoBrowser());
  }

  ///构建图片浏览页组件
  Widget buildPhotoBrowser() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(height: height),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            buildPhotoBrowserGalleryPreView(),
            buildPhotoBrowserTitle()
          ],
        ),
      ),
    );
  }

  ///构建图片浏览页-标题组件
  Widget buildPhotoBrowserTitle() {
    return Padding(
      padding: EdgeInsets.all(20.px),
      child: Text("Image ${idx + 1}", style: TextStyle(color: Colors.white, fontSize: 17.px)),
    );
  }

  ///构建图片浏览页-预览组件
  Widget buildPhotoBrowserGalleryPreView() {
    return PhotoViewGallery.builder(
      wantKeepAlive: true,
      itemCount: widget.images.length,
      customSize: Size(width - 10.px, double.infinity),
      scrollPhysics: const BouncingScrollPhysics(),
      builder: buildPhotoBrowserGalleryPreViewItem,
      loadingBuilder: widget.loadingBuilder ?? buildPhotoBrowserGalleryPreViewLoading,
      backgroundDecoration: widget.backgroundDecoration,
      pageController: widget.pageController,
      onPageChanged: (index) => setState(() => idx = index)
    );
  }

  ///构建图片浏览页-预览item组件
  PhotoViewGalleryPageOptions buildPhotoBrowserGalleryPreViewItem(BuildContext context, int index) {
    final AssetEntity entity = widget.images[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetEntityImageProvider(entity, isOriginal: false),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered,
      heroAttributes: PhotoViewHeroAttributes(tag: entity),
    );
  }

  ///构建图片浏览页-loading组件
  Widget buildPhotoBrowserGalleryPreViewLoading(BuildContext context,ImageChunkEvent? event) {
    return Center(
      child: SizedBox(
        width: 20.px,
        height: 20.px,
        child: CircularProgressIndicator(
          value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? event.cumulativeBytesLoaded),
        ),
      ),
    );
  }
}
