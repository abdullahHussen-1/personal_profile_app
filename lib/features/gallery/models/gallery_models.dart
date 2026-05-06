
class GalleryImageModel {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final bool isFavorite;
  final DateTime createdAt;

  const GalleryImageModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.createdAt,
  });

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) =>
      GalleryImageModel(
        id:          json['id'] as int,
        imageUrl:    json['imageUrl'] as String,
        title:       json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        isFavorite:  json['isFavorite'] as bool? ?? false,
        createdAt:   DateTime.parse(json['createdAt'] as String),
      );
}
