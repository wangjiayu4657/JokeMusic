class UserInfoModel {
  UserInfoModel({
    required this.userId,
    required this.nickname,
    required this.avatar,
    required this.signature,
    required this.birthday,
    required this.sex,
    required this.userPhone,
    required this.invitedCode,
    required this.inviteCode,
  });

  String userId;
  String nickname;
  String avatar;
  String signature;
  String birthday;
  String sex;
  String userPhone;
  String invitedCode;
  String inviteCode;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    userId: json["userId"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    signature: json["signature"],
    birthday: json["birthday"],
    sex: json["sex"],
    userPhone: json["userPhone"],
    invitedCode: json["invitedCode"],
    inviteCode: json["inviteCode"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nickname": nickname,
    "avatar": avatar,
    "signature": signature,
    "birthday": birthday,
    "sex": sex,
    "userPhone": userPhone,
    "invitedCode": invitedCode,
    "inviteCode": inviteCode,
  };
}