
class ProfileStatsModel {
  final int totalPhotos;
  final int favoritePhotos;

  const ProfileStatsModel({
    required this.totalPhotos,
    required this.favoritePhotos,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) =>
      ProfileStatsModel(
        totalPhotos:    json['totalPhotos'] as int,
        favoritePhotos: json['favoritePhotos'] as int,
      );
}
