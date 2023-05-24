///用户社交信息
class SocialInfo {
  int? attentionNum;    //关注数量
  int? experienceNum;   //经验值
  int? fansNum;         //粉丝数量
  int? likeNum;         //喜欢数量

  SocialInfo({
    this.attentionNum,
    this.experienceNum,
    this.fansNum,
    this.likeNum,
  });

  factory SocialInfo.fromJson(Map<String, dynamic> json) => SocialInfo(
    attentionNum: json["attentionNum"],
    experienceNum: json["experienceNum"],
    fansNum: json["fansNum"],
    likeNum: json["likeNum"],
  );

  Map<String, dynamic> toJson() => {
    "attentionNum": attentionNum,
    "experienceNum": experienceNum,
    "fansNum": fansNum,
    "likeNum": likeNum,
  };
}
