import 'dart:async';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart';

import '../../../services/http/http.dart';
import '../../../common/video_item.dart';
import '../../../tools/event_bus/event_bus.dart';
import '../../../pages/home/models/video_item.dart';
import '../../../pages/home/widgets/home_item_page.dart';


class HomeItemController extends GetxController {
  late List<VideoItem> items = [];
  late HomeItemType _homeItemType = HomeItemType.focus;
  late final StreamSubscription? _streamSubscription;

  ItemType get itemType {
    if (_homeItemType.index == 3) {
      return ItemType.text;
    } else if (_homeItemType.index == 4) {
      return ItemType.picture;
    } else {
      return ItemType.video;
    }
  }

  String get _itemUrl {
    switch (_homeItemType) {
      case HomeItemType.recommend: return "/home/recommend";
      case HomeItemType.refresh: return "/home/latest";
      case HomeItemType.text: return "/home/text";
      case HomeItemType.picture: return "/home/pic";
      default: return "/home/attention/list";
    }
  }

  @override
  void onInit() {
    _streamSubscription = bus.on<VideoRequestEvent>().listen((event) {
      _homeItemType = event.homeItemType;
      itemDataRequest();
    });

    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  //请求数据
  void itemDataRequest() async {
    final response = await Http.post(url: _itemUrl);

    if(response.data == null) return;

    for(dynamic json in response.data){
       final item = VideoItem.fromJson(json);

       //解密处理
       item.joke?.imageUrl = handlerUrl(item.joke?.imageUrl);
       item.joke?.videoUrl = handlerUrl(item.joke?.videoUrl);

       //放入容器
       items.add(item);
    }

    update();
  }

  ///解密图片/视频地址
  String? handlerUrl(String? path){
    if(path == null || path.isEmpty == true || (path.length) < 6) return null;

    final tempUrl = path.substring(6);

    final key = Key.fromUtf8('cretinzp**273846');
    final iv = IV.fromLength(16);
    final encrypt = Encrypter(AES(key, mode: AESMode.ecb, padding: "PKCS7"));

    final encryptedText = Encrypted.fromBase64(tempUrl);
    final decrypted = encrypt.decrypt(encryptedText, iv: iv);
    final url = decrypted.toString();

    return url;
  }
}