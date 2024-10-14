import 'package:flutter_test/flutter_test.dart';
import 'package:hayiqu/hayiqu.dart';

import 'http_service_test.mock.dart';

void main() {
  const String baseUrl = "https://jsonplaceholder.typicode.com";
  group('HttpService with Dependency Injection Test', () {
    late final HttpService httpService;
    late final MockPostModel dummyData;
    setUpAll(() async {
      await setupLocator(() {});

      httpService = getIt<HttpService>();
      httpService.setBaseUrl(baseUrl);
      httpService.enableLogger(false);

      dummyData = MockPostModel.dummy();
    });

    test('GET Request', () async {
      final result =
          await httpService.get("/users", queryParameters: {"id": 1});
      expectResult(result);
    });
    test('POST Request', () async {
      final result = await httpService.post("/posts", data: dummyData.toMap());
      expectResult(result);
    });
    test('PUT Request', () async {
      final result = await httpService.put("/posts/1", data: dummyData.toMap());
      expectResult(result);
    });
    test('PATCH Request', () async {
      final result =
          await httpService.patch("/posts/1", data: dummyData.toMap());
      expectResult(result);
    });

    test('DELETE Request', () async {
      final result =
          await httpService.delete("/posts/1", data: dummyData.toMap());
      expectResult(result);
    });
  });
}

void expectResult(Result<Response, Exception> result) {
  expect(result.hasError, false);
  expect(result.error == null, true);
  expect(result.hasValue, true);
  expect(result.value != null, true);
}
