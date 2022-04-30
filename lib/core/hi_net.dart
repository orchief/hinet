import 'package:hinet/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(HiNetBaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    printLog(request, result);
    return result;
  }

  Future<dynamic> send(HiNetBaseRequest request) async {
    printLog(request, 'url: ${request.url()}');
    printLog(request, 'method: ${request.httpMethod()}');
    printLog(request, 'header: ${request.header}');
    printLog(request, 'params: ${request.params}');
    return Future.value({
      "statusCode": 200,
      "data": {"code": 0, "message": "success"}
    });
  }

  void printLog(request, log) {
    if (request.kDebugMode()) {
      // ignore: avoid_print
      print('hi_net: ${log.toString()}');
    }
  }
}
