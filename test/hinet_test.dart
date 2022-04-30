import 'package:flutter_test/flutter_test.dart';
import 'package:hinet/core/hi_net.dart';

import 'test_request.dart';

void main() {
  test('测试接口返回格式结果', () async {
    TestRequest request = TestRequest();
    request.add('aa', 'bbb');
    request.addHeader('token', 'value');
    var result = await HiNet.getInstance().fire(request);

    expect(result['args'], {'aa': 'bbb'});
    expect(result['headers']['Token'], 'value');
    expect(result['url'], request.url());
  });
}
