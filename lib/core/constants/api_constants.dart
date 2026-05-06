class ApiConstants {
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';

  static const String profile = '/profile';
  static const String avatar = '/profile/avatar';
  static const String changePassword = '/profile/change-password';
  static const String profileStats = '/profile/stats';

  static const String gallery = '/gallery';
  static const String galleryFavorites = '/gallery/favorites';

  static String galleryById(int id) => '/gallery/$id';

  static String galleryFavorite(int id) => '/gallery/$id/favorite';
  static const String galleryUpload = '/gallery/upload';

  static const String settings = '/settings';

  static const String about = '/about';
  static const String contact = '/support/contact';
}
