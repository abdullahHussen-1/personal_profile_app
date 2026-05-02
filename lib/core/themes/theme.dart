import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
  );
}
