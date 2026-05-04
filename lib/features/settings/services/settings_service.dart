
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/constants/api_constants.dart';
import '../models/settings_models.dart';

class SettingsService {
  final _dio = ApiClient.instance.dio;

  Future<ApiResponse<SettingsModel>> getSettings() async {
    try {
      final res = await _dio.get(ApiConstants.settings);
      return ApiResponse.fromJson(res.data, (d) => SettingsModel.fromJson(d));
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<SettingsModel>> updateSettings({
    required bool darkMode,
    required bool notificationsEnabled,
  }) async {
    try {
      final res = await _dio.put(
        ApiConstants.settings,
        data: {
          'darkMode':             darkMode,
          'notificationsEnabled': notificationsEnabled,
        },
      );
      return ApiResponse.fromJson(res.data, (d) => SettingsModel.fromJson(d));
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  ApiResponse<T> _handleError<T>(DioException e) {
    final msg = e.response?.data?['message'] as String? ??
        e.message ??
        'Something went wrong';
    return ApiResponse(success: false, message: msg);
  }
}
