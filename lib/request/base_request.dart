// ignore_for_file: constant_identifier_names
enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  // 请求路径参数 类似 /detail/1
  String pathParams = "";

  // 请求参数
  Map<String, String> params = {};

  // 请求header
  Map<String, dynamic> header = {};
  // 是否启用https
  bool useHttps() {
    return true;
  }

  // 是否开启debug
  bool kDebugMode() {
    return false;
  }

  // 域名
  String authority() {
    return "api.devio.org";
  }

  // 请求方法
  HttpMethod httpMethod();

  // 是否需要登陆
  bool needLogin();

  // 请求路径
  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接参数
    if (pathStr.endsWith('/')) {
      pathStr = "$pathStr$pathParams";
    } else {
      pathStr = "$pathStr/$pathParams";
    }
    // http和https切换
    if (useHttps()) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if (kDebugMode()) {
      // ignore: avoid_print
      print('url: ${uri.toString()}');
    }
    return uri.toString();
  }

  /// 添加参数
  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  // 添加header
  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    return this;
  }
}
