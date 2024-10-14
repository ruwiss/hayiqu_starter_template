import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:hayiqu/hayiqu.dart';
import 'dart:async';

class HttpService {
  late Dio dio;
  final Map<String, Response> _cache = {};

  HttpService() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {'Content-Type': 'application/json'},
    );

    dio = Dio(options);
    enableLogger(true);
  }

  final PrettyDioLogger _logger = PrettyDioLogger();
  BaseOptions get options => dio.options;

  void setBaseUrl(String baseUrl) => options.baseUrl = baseUrl;

  void setHeaders(Map<String, dynamic> headers) => options.headers = headers;

  void enableLogger(bool value) =>
      value ? dio.interceptors.add(_logger) : dio.interceptors.remove(_logger);

  // GET request (with caching)
  Future<Result<Response, DioException>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useCache = true,
    int retryCount = 3, // Maximum number of retries
    int retryDelay = 1000, // Retry delay (ms)
  }) async {
    try {
      if (useCache && _cache.containsKey(endpoint)) {
        return Result.value(input: _cache[endpoint]!);
      }

      Response response = await _makeRequest(
        () => dio.get(
          endpoint,
          queryParameters: queryParameters,
          options: options,
        ),
        retryCount,
        retryDelay,
      );

      if (useCache) {
        _cache[endpoint] = response;
      }

      return Result.value(input: response);
    } on DioException catch (e) {
      return Result.error(input: e);
    }
  }

  // POST request
  Future<Result<Response, DioException>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 3,
    int retryDelay = 1000,
  }) async {
    try {
      Response response = await _makeRequest(
        () => dio.post(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
        retryCount,
        retryDelay,
      );
      return Result.value(input: response);
    } on DioException catch (e) {
      return Result.error(input: e);
    }
  }

  // PUT request
  Future<Result<Response, DioException>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 3,
    int retryDelay = 1000,
  }) async {
    try {
      Response response = await _makeRequest(
        () => dio.put(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
        retryCount,
        retryDelay,
      );
      return Result.value(input: response);
    } on DioException catch (e) {
      return Result.error(input: e);
    }
  }

  // PATCH request
  Future<Result<Response, DioException>> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 3,
    int retryDelay = 1000,
  }) async {
    try {
      Response response = await _makeRequest(
        () => dio.patch(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
        retryCount,
        retryDelay,
      );
      return Result.value(input: response);
    } on DioException catch (e) {
      return Result.error(input: e);
    }
  }

  // DELETE request
  Future<Result<Response, DioException>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 3,
    int retryDelay = 1000,
  }) async {
    try {
      Response response = await _makeRequest(
        () => dio.delete(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
        retryCount,
        retryDelay,
      );
      return Result.value(input: response);
    } on DioException catch (e) {
      return Result.error(input: e);
    }
  }

  // File download function
  Future<Result<bool, DioException>> download({
    required String url,
    required String savePath,
    required Function(int received, int total) onProgress,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 3,
    int retryDelay = 1000,
  }) async {
    try {
      await _makeRequest(
        () => dio.download(
          url,
          savePath,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              onProgress(received, total);
            }
          },
        ),
        retryCount,
        retryDelay,
      );
      return const Result.value(input: true);
    } on DioException catch (e) {
      return Result.error(input: e);
    }
  }

  // Helper function to manage retry attempts
  Future<Response> _makeRequest(
    Future<Response> Function() requestFunction,
    int retryCount,
    int retryDelay,
  ) async {
    int attempts = 0;
    while (attempts < retryCount) {
      try {
        return await requestFunction();
      } on DioException catch (e) {
        if (attempts == retryCount - 1 || !shouldRetry(e)) {
          rethrow;
        }
        await Future.delayed(Duration(milliseconds: retryDelay));
        attempts++;
      }
    }
    throw Exception('Max retry attempts exceeded');
  }

  // Function that checks if a retry is possible
  bool shouldRetry(DioException error) {
    // We can retry on connection errors or timeout
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.unknown;
  }

  // Cache clearing function
  void clearCache() {
    _cache.clear();
  }
}
