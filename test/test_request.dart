import 'package:hinet/request/base_request.dart';

class TestRequest extends HiNetBaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool useHttps() {
    return false;
  }

  @override
  bool kDebugMode() {
    return false;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'get';
  }

  @override
  String authority() {
    // 测试用mock网站
    return 'httpbin.org';
  }
}
