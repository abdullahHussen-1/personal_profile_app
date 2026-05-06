import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../models/gallery_models.dart';

class GalleryService {
  final _dio = ApiClient.instance.dio;

  Future<ApiResponse<List<GalleryImageModel>>> getAll({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await _dio.get(
        ApiConstants.gallery,
        queryParameters: {'pageNumber': page, 'pageSize': pageSize},
      );

      final responseData = res.data['data'];

      final List list = responseData['data'];

      return ApiResponse(
        success: true,
        message: res.data['message'],
        data: list.map((e) => GalleryImageModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GalleryImageModel>> getById(int id) async {
    try {
      final res = await _dio.get(ApiConstants.galleryById(id));
      return ApiResponse.fromJson(
        res.data,
        (d) => GalleryImageModel.fromJson(d),
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> uploadImages(List<String> imagePaths) async {
    try {
      final formData = FormData();

      for (var path in imagePaths) {
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(path, filename: path.split('/').last),
          ),
        );
      }

      final res = await _dio.post(
        ApiConstants.galleryUpload,
        data: formData,
        onSendProgress: (sent, total) {
          final percent = (sent / total * 100).toStringAsFixed(0);
        },
      );

      return ApiResponse.fromJson(res.data, (d) => d?.toString() ?? "");
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: e.response?.data?['message'] ?? e.message ?? 'Upload failed',
      );
    }
  }

  Future<ApiResponse<String>> deleteImage(int id) async {
    try {
      final res = await _dio.delete(ApiConstants.galleryById(id));
      return ApiResponse.fromJson(res.data, (d) => d as String);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<List<GalleryImageModel>>> getFavorites() async {
    try {
      final res = await _dio.get(ApiConstants.galleryFavorites);
      return ApiResponse.fromJson(
        res.data,
        (d) => (d as List).map((e) => GalleryImageModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> addFavorite(int id) async {
    try {
      final res = await _dio.post(ApiConstants.galleryFavorite(id));
      return ApiResponse.fromJson(res.data, (d) => d as String);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> removeFavorite(int id) async {
    try {
      final res = await _dio.delete(ApiConstants.galleryFavorite(id));
      return ApiResponse.fromJson(res.data, (d) => d as String);
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
