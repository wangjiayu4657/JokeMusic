import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart';
import 'package:easy_refresh/easy_refresh.dart';

import '../../../services/http/http.dart';
import '../../../services/http/response/base_response.dart';
import '../../../pages/home/models/video_item.dart';
import '../../../pages/home/widgets/home_item_page.dart';


class HomeItemController extends GetxController {
  HomeItemController({this.homeItemType = HomeItemType.focus});

  late int page = 1;
  late List<VideoItem> items = [];
  late HomeItemType homeItemType;
  late bool isLoading = true; //是否正在加载中
  late bool isUpLoading = true; //是否正在上拉加载中
  late final refreshCtrl = EasyRefreshController();


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
    refreshCtrl.callRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    refreshCtrl.dispose();
    super.onClose();
  }

  ///下拉刷新
  void onRefresh() async {
    page = 1;
    isLoading = true;
    dataRequest(page);
  }

  ///上拉加载
  void onLoad() async {
    if(isUpLoading){      //防止多次调用
      page += 1;
      isUpLoading = false;
      dataRequest(page);
    }
  }

  //请求数据
  void dataRequest(int page) async {
    final params = {"page": page};
    final response = await Http.post<JYBaseResponse>(url: _itemUrl, params: params);

    if (response.data == null) {
      isLoading = false;
      isUpLoading = true;
      update(['$homeItemType']);

      refreshCtrl.finishLoad(IndicatorResult.noMore, true);

      return;
    }

    //如果是下拉刷新则先清空数组
    if (page == 1) {
      items.clear();
      refreshCtrl.resetFooter();
    }

    for (dynamic json in response.data) {
      final item = VideoItem.fromJson(json);

      //解密处理
      item.joke?.imageUrl = decryptionUrl(item.joke?.imageUrl);
      item.joke?.videoUrl = decryptionUrl(item.joke?.videoUrl);

      //放入容器
      items.add(item);
    }

    isLoading = false;
    isUpLoading = true;
    update(['$homeItemType']);
  }

  ///解密图片/视频地址
  String? decryptionUrl(String? path){
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