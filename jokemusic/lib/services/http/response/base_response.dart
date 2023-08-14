class JYBaseResponse {
  JYBaseResponse._({
    this.code,
    this.data,
    this.msg,
  });

  int? code;
  String? msg;
  dynamic data;

  static JYBaseResponse fromJson(Map<String, dynamic> map) {
    return JYBaseResponse._(
      data: map['data'],
      code: map['code'],
      msg: map['msg'],
    );
  }
}