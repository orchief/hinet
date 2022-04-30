import 'dart:convert';

import 'package:hinet/request/base_request.dart';

///网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(HiNetBaseRequest request);
}

/// 统一网络层返回格式
class HiNetResponse<T> {
  HiNetResponse({
    this.data,
    required this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  T? data;

  /// The corresponding request info.
  HiNetBaseRequest request;

  /// Http status code.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? statusMessage;

  /// Custom field that you can retrieve it later in `then`.
  late dynamic extra;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
