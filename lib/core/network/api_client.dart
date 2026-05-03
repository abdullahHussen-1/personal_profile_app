
import 'package:dio/dio.dart';
import 'token_storage.dart';

class ApiClient {
  static ApiClient? _instance;
  late final Dio _dio;

  ApiClient._() {
    const baseUrl = 'https://personalprofileapi-duanacebc6fsdgdv.northeurope-01.azurewebsites.net/api';

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.get();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },

        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            TokenStorage.delete();
          }
          handler.next(e);
        },
      ),
    );
  }

  static ApiClient get instance {
    _instance ??= ApiClient._();
    return _instance!;
  }

  Dio get dio => _dio;
}
