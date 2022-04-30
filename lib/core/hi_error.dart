/// 异常处理类
class HiNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiNetError(this.code, this.message, {this.data});
}

/// 需要授权
class NeedAuthError extends HiNetError {
  NeedAuthError(String string, {int code = 403, String message = "需要授权", data})
      : super(code, message);
}

/// 需要登陆
class NeedLoginError extends HiNetError {
  NeedLoginError({int code = 401, String message = "需要登陆"})
      : super(code, message);
}
