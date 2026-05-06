import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  ThemeProvider() {
    _initTheme();
  }

  Future<void> _initTheme() async {
    bool isDark = await _themeService.loadTheme();
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _themeService.saveTheme(isDark);
    notifyListeners();
  }
}
