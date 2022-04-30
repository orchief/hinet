import 'package:hinet/core/hi_net_adapter.dart';
import 'package:hinet/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiNetBaseRequest request) async {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse(
          request: request,
          data: {"code": 0, "message": 'success'} as T,
          statusCode: 403);
    });
  }
}
