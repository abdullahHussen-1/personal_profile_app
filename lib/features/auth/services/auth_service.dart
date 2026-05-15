import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/token_storage.dart';
import '../../../data/api_response.dart';
import '../models/auth_models.dart';

class AuthService {
  final _dio = ApiClient.instance.dio;

  Future<ApiResponse<AuthResponse>> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final res = await _dio.post(
        ApiConstants.register,
        data: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );
      final response = ApiResponse<AuthResponse>.fromJson(
        res.data,
        (data) => AuthResponse.fromJson(data),
      );
      if (response.success && response.data != null) {
        await TokenStorage.save(response.data!.token);
      }
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      final response = ApiResponse<AuthResponse>.fromJson(
        res.data,
        (data) => AuthResponse.fromJson(data),
      );
      if (response.success && response.data != null) {
        await TokenStorage.save(response.data!.token);
      }
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } catch (_) {
    } finally {
      await TokenStorage.delete();
    }
  }

  ApiResponse<AuthResponse> _handleError(e) {
    final msg =
        e.response?.data?['message'] as String? ??
        e.message ??
        'Something went wrong';
    return ApiResponse(success: false, message: msg);
  }
}
