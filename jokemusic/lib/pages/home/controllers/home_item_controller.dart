import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart' as decode;
import 'package:flutter/material.dart';

import '../../../tools/extension/object_extension.dart';
import '../../../services/http/http.dart';
import '../../../pages/home/models/video_item.dart';
import '../../../pages/home/widgets/home_item_page.dart';


class HomeItemController extends GetxController {
  HomeItemController({this.homeItemType = HomeItemType.focus});

  late List<VideoItem> items = [];
  late HomeItemType homeItemType;
  late bool isLoading = true;

  String get _itemUrl {
    switch (homeItemType) {
      case HomeItemType.recommend: return "/home/recommend";
      case HomeItemType.refresh: return "/home/latest";
      case HomeItemType.text: return "/home/text";
      case HomeItemType.picture: return "/home/pic";
      default: return "/home/attention/list";
    }
  }

  @override
  void onReady() {
    dataRequest();
    super.onReady();
  }

  //请求数据
  void dataRequest() async {
    final response = await Http.post(url: _itemUrl);

    if(response.data == null) {
      isLoading = false;
      update();
      return;
    }

    for(dynamic json in response.data){
      final item = VideoItem.fromJson(json);

      //处理图片尺寸
      // item.joke?.imgSize = handlerSize(item.joke?.imageSize);
      //解密处理
      item.joke?.imageUrl = decryptionUrl(item.joke?.imageUrl);
      item.joke?.videoUrl = decryptionUrl(item.joke?.videoUrl);

      //放入容器
      items.add(item);
    }

    isLoading = false;
    update();
  }

  // Size handlerSize(String? size){
  //   final sizes = size?.split('x');
  //   double width = mapToDouble(sizes?.first);
  //   double height = mapToDouble(sizes?.last);
  //   return Size(width,height);
  // }

  ///解密图片/视频地址
  String? decryptionUrl(String? path){
    if(path == null || path.isEmpty == true || (path.length) < 6) return null;

    final tempUrl = path.substring(6);

    final key = decode.Key.fromUtf8('cretinzp**273846');
    final iv = decode.IV.fromLength(16);
    final encrypt = decode.Encrypter(decode.AES(key, mode: decode.AESMode.ecb, padding: "PKCS7"));

    final encryptedText = decode.Encrypted.fromBase64(tempUrl);
    final decrypted = encrypt.decrypt(encryptedText, iv: iv);
    final url = decrypted.toString();

    return url;
  }
}