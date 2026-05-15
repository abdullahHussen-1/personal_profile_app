import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../data/api_response.dart';
import '../../auth/models/auth_models.dart';
import '../models/profile_models.dart';

class ProfileService {
  final _dio = ApiClient.instance.dio;

  Future<ApiResponse<UserModel>> getProfile() async {
    try {
      final res = await _dio.get(ApiConstants.profile);
      return ApiResponse.fromJson(res.data, (d) => UserModel.fromJson(d));
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<UserModel>> updateProfile({
    required String fullName,
    required String phone,
    required String bio,
    required String email,
  }) async {
    try {
      final res = await _dio.put(
        ApiConstants.profile,
        data: {
          'fullName': fullName,
          'phone': phone,
          'bio': bio,
          'email': email,
        },
      );
      return ApiResponse.fromJson(res.data, (d) => UserModel.fromJson(d));
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> uploadAvatar(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
      });

      final res = await _dio.post(ApiConstants.avatar, data: formData);

      return ApiResponse.fromJson(res.data, (d) => d as String);
    } on DioException catch (e) {
      print("ERROR STATUS: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");

      return ApiResponse(
        success: false,
        message: e.response?.data?['message'] ?? e.message ?? 'Upload failed',
      );
    }
  }

  Future<ApiResponse<ProfileStatsModel>> getStats() async {
    try {
      final res = await _dio.get(ApiConstants.profileStats);
      return ApiResponse.fromJson(
        res.data,
        (d) => ProfileStatsModel.fromJson(d),
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  ApiResponse<T> _handleError<T>(DioException e) {
    final msg =
        e.response?.data?['message'] as String? ??
        e.message ??
        'Something went wrong';
    return ApiResponse(success: false, message: msg);
  }
}
