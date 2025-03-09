abstract class BaseResponse<T> {
  bool? isOk;
  String? message;
  T? data;

  BaseResponse({this.isOk, this.message, this.data});
}
