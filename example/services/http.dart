import 'package:hayiqu/hayiqu.dart';

class ApiService {
  final _httpService = getIt<HttpService>();

  void config() {
    // _httpService.enableLogger(true);
    // _httpService.setBaseUrl("example.com");
    // _httpService.setHeaders({});
    // _httpService.dio.options.connectTimeout = const Duration(seconds: 5);
    // _httpService.dio.interceptors.add();
  }

// GET request (with cache)
  void _exampleGetRequest() async {
    final Result result = await _httpService.get("/users", useCache: true);
    if (result.hasValue) {}
    if (result.hasError) {
      result.requireError.message.log();
    }
  }

// POST request
  void _examplePostRequest() async {
    final Map<String, dynamic> data = {"name": "John Doe"};
    final Result result = await _httpService.post("/users", data: data);
    if (result.hasValue) {}
    if (result.hasError) {
      result.requireError.message.log();
    }
  }

// PUT request
  void _examplePutRequest() async {
    final Map<String, dynamic> data = {"name": "John Doe"};
    final Result result = await _httpService.put("/users/1", data: data);
    if (result.hasValue) {}
    if (result.hasError) {
      result.requireError.message.log();
    }
  }

// DELETE request
  void _exampleDeleteRequest() async {
    final Result result = await _httpService.delete("/users/1");
    if (result.hasValue) {}
    if (result.hasError) {
      result.requireError.message.log();
    }
  }

// Single file download
  void _exampleDownload() async {
    final Result result = await _httpService.download(
      url: "https://example.com/file.pdf",
      savePath: "example.pdf",
      onProgress: (received, total) {
        // Progress handling
      },
    );
    if (result.hasValue) {}
    if (result.hasError) {
      result.requireError.message.log();
    }
  }
}
