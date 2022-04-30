import 'package:hinet/core/hi_error.dart';
import 'package:hinet/core/hi_net_adapter.dart';
import 'package:hinet/request/base_request.dart';
import 'package:dio/dio.dart';

///Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiNetBaseRequest request) async {
    dynamic response, options = Options(headers: request.header);
    dynamic error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      ///抛出HiNetError
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, HiNetBaseRequest request) {
    return Future.value(HiNetResponse(
        //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
