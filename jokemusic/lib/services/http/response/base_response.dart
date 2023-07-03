class BaseResponse {
  BaseResponse._({
    this.code,
    this.data,
    this.msg,
  });

  int? code;
  String? msg;
  dynamic data;

  static BaseResponse fromJson(Map<String, dynamic> map) {
    return BaseResponse._(
      data: map['data'],
      code: map['code'],
      msg: map['msg'],
    );
  }
}