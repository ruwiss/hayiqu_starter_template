import 'package:dio/dio.dart';
import 'dart:async';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

  void setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  void setHeaders(Map<String, dynamic> headers) {
    dio.options.headers = headers;
  }

  final PrettyDioLogger _logger = PrettyDioLogger();

  void enableLogger(bool value) {
    value ? dio.interceptors.add(_logger) : dio.interceptors.remove(_logger);
  }

  // GET isteği (Önbellek ile birlikte)
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useCache = true,
    int retryCount = 3, // Maksimum yeniden deneme sayısı
    int retryDelay = 1000, // Yeniden deneme gecikmesi (ms)
  }) async {
    try {
      if (useCache && _cache.containsKey(endpoint)) {
        return _cache[endpoint]!;
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

      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // POST isteği
  Future<Response> post(
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
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // PUT isteği
  Future<Response> put(
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
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // DELETE isteği
  Future<Response> delete(
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
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Dosya indirme fonksiyonu
  Future<void> download({
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
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Tekrar deneme işlemini yöneten yardımcı fonksiyon
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

  // Retry yapılabilirliği kontrol eden fonksiyon
  bool shouldRetry(DioException error) {
    // Bağlantı hatası veya timeout durumunda tekrar deneyebiliriz
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.unknown;
  }

  // Hata yönetimi için yardımcı fonksiyon
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return Exception("İstek iptal edildi");
      case DioExceptionType.connectionTimeout:
        return Exception("Bağlantı zaman aşımına uğradı");
      case DioExceptionType.unknown:
        return Exception("Bir hata oluştu: ${error.message}");
      case DioExceptionType.receiveTimeout:
        return Exception("Yanıt zaman aşımına uğradı");
      case DioExceptionType.badResponse:
        return Exception(
            "Kötü Yanıt: ${error.response?.statusCode} ${error.response?.statusMessage}");
      case DioExceptionType.sendTimeout:
        return Exception("Gönderme zaman aşımına uğradı");
      default:
        return Exception("Bilinmeyen bir hata oluştu");
    }
  }

  // Önbellekleme temizleme işlemi
  void clearCache() {
    _cache.clear();
  }
}
