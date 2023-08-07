// To parse this JSON data, do
//
//     final videoItem = videoItemFromJson(jsonString);
import 'package:encrypt/encrypt.dart';


class VideoItem {
  Info? info;
  Joke? joke;
  User? user;

  VideoItem({
    this.info,
    this.joke,
    this.user,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) => VideoItem(
    info: Info.fromJson(json["info"]),
    joke: Joke.fromJson(json["joke"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "joke": joke?.toJson(),
    "user": user?.toJson(),
  };
}

class Info {
  int? commentNum;
  int? disLikeNum;
  bool? isAttention;
  bool? isLike;
  bool? isUnlike;
  int? likeNum;
  int? shareNum;

  Info({
    this.commentNum,
    this.disLikeNum,
    this.isAttention,
    this.isLike,
    this.isUnlike,
    this.likeNum,
    this.shareNum,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    commentNum: json["commentNum"],
    disLikeNum: json["disLikeNum"],
    isAttention: json["isAttention"],
    isLike: json["isLike"],
    isUnlike: json["isUnlike"],
    likeNum: json["likeNum"],
    shareNum: json["shareNum"],
  );

  Map<String, dynamic> toJson() => {
    "commentNum": commentNum,
    "disLikeNum": disLikeNum,
    "isAttention": isAttention,
    "isLike": isLike,
    "isUnlike": isUnlike,
    "likeNum": likeNum,
    "shareNum": shareNum,
  };
}

class Joke {
  String? addTime;
  String? auditMsg;
  String? content;
  bool? hot;
  String? imageSize;
  String? imageUrl;
  int? jokesId;
  String? latitudeLongitude;
  String? showAddress;
  String? thumbUrl;
  int? type;
  int? userId;
  String? videoSize;
  int? videoTime;
  String? videoUrl;

  Joke({
    this.addTime,
    this.auditMsg,
    this.content,
    this.hot,
    this.imageSize,
    this.imageUrl,
    this.jokesId,
    this.latitudeLongitude,
    this.showAddress,
    this.thumbUrl,
    this.type,
    this.userId,
    this.videoSize,
    this.videoTime,
    this.videoUrl,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
    addTime: json["addTime"],
    auditMsg: json["audit_msg"],
    content: json["content"],
    hot: json["hot"],
    imageSize: json["imageSize"],
    imageUrl: json["imageUrl"],
    jokesId: json["jokesId"],
    latitudeLongitude: json["latitudeLongitude"],
    showAddress: json["showAddress"],
    thumbUrl: json["thumbUrl"],
    type: json["type"],
    userId: json["userId"],
    videoSize: json["videoSize"],
    videoTime: json["videoTime"],
    videoUrl: json["videoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "addTime": addTime,
    "audit_msg": auditMsg,
    "content": content,
    "hot": hot,
    "imageSize": imageSize,
    "imageUrl": imageUrl,
    "jokesId": jokesId,
    "latitudeLongitude": latitudeLongitude,
    "showAddress": showAddress,
    "thumbUrl": thumbUrl,
    "type": type,
    "userId": userId,
    "videoSize": videoSize,
    "videoTime": videoTime,
    "videoUrl": videoUrl,
  };
}

class User {
  String? avatar;
  String? nickName;
  String? signature;
  int? userId;

  User({
    this.avatar,
    this.nickName,
    this.signature,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    avatar: json["avatar"],
    nickName: json["nickName"],
    signature: json["signature"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "nickName": nickName,
    "signature": signature,
    "userId": userId,
  };
}
