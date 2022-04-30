import 'package:hinet/request/base_request.dart';

class BaseRequest extends HiNetBaseRequest {
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
}
