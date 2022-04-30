import 'package:hinet/core/hi_error.dart';
import 'package:hinet/core/hi_net_adapter.dart';
import 'package:hinet/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(HiNetBaseRequest request) async {
    HiNetResponse? response;
    dynamic error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(request, e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(request, e);
    }
    if (response == null) {
      printLog(request, error);
    }
    var result = response?.data;
    printLog(request, result);
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLoginError();
      case 403:
        throw NeedAuthError(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<dynamic> send(HiNetBaseRequest request) async {
    printLog(request, 'url: ${request.url()}');
    printLog(request, 'method: ${request.httpMethod()}');
    printLog(request, 'header: ${request.header}');
    printLog(request, 'params: ${request.params}');
    HiNetAdapter adapter = request.hiNetAdapter();
    return adapter.send(request);
  }

  void printLog(request, log) {
    if (request.kDebugMode()) {
      // ignore: avoid_print
      print('hi_net: ${log.toString()}');
    }
  }
}
