
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/constants/api_constants.dart';
import '../models/gallery_models.dart';

class GalleryService {
  final _dio = ApiClient.instance.dio;

  Future<ApiResponse<List<GalleryImageModel>>> getAll() async {
    try {
      final res = await _dio.get(ApiConstants.gallery);
      return ApiResponse.fromJson(
        res.data,
        (d) => (d as List)
            .map((e) => GalleryImageModel.fromJson(e))
            .toList(),
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GalleryImageModel>> getById(int id) async {
    try {
      final res = await _dio.get(ApiConstants.galleryById(id));
      return ApiResponse.fromJson(
          res.data, (d) => GalleryImageModel.fromJson(d));
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GalleryImageModel>> addImage({
    required String imageUrl,
    required String title,
    required String description,
  }) async {
    try {
      final res = await _dio.post(
        ApiConstants.gallery,
        data: {
          'imageUrl':    imageUrl,
          'title':       title,
          'description': description,
        },
      );
      return ApiResponse.fromJson(
          res.data, (d) => GalleryImageModel.fromJson(d));
    } on DioException catch (e) {
      return _handleError(e);
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
        (d) => (d as List)
            .map((e) => GalleryImageModel.fromJson(e))
            .toList(),
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
    final msg = e.response?.data?['message'] as String? ??
        e.message ??
        'Something went wrong';
    return ApiResponse(success: false, message: msg);
  }
}
