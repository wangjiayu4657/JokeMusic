class UserInfoModel {
  UserInfoModel({
     this.userId,
     this.nickname,
     this.avatar,
     this.signature,
     this.birthday,
     this.sex,
     this.userPhone,
     this.inviteCode,
     this.invitedCode,
  });

  ///用户id
  int? userId;
  ///昵称
  String? nickname;
  ///用户头像
  String? avatar;
  ///用户签名
  String? signature;
  ///用户生日
  String? birthday;
  ///用户性别
  String? sex;
  ///用户手机号
  String? userPhone;
  ///用户邀请码
  String? inviteCode;
  ///用户被邀请码
  String? invitedCode;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    userId: json["userId"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    signature: json["signature"],
    birthday: json["birthday"],
    sex: json["sex"],
    userPhone: json["userPhone"],
    inviteCode: json["inviteCode"],
    invitedCode: json["invitedCode"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nickname": nickname,
    "avatar": avatar,
    "signature": signature,
    "birthday": birthday,
    "sex": sex,
    "userPhone": userPhone,
    "inviteCode": inviteCode,
    "invitedCode": invitedCode,
  };
}