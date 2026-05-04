import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/styles/app_style.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';

/*class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}*/

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightSurface,
    dividerColor: AppColors.lightDividerColor,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      titleTextStyle: AppStyle.titleLightStyle,
      foregroundColor: AppColors.lightTextPrimary,
      iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.lightDividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.lightDividerColor),
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(color: AppColors.lightTextPrimary, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14),
      headlineLarge: AppStyle.titleInfoLightStyle,
    ),

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryBlue,
      surface: AppColors.lightSurface,
      background: AppColors.lightBackground,
      error: AppColors.errorRed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkSurface,
    dividerColor: AppColors.darkBorder,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      titleTextStyle: AppStyle.titleDarkStyle,
      foregroundColor: AppColors.darkTextPrimary,
      iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.white, fontSize: 14),
      headlineLarge: AppStyle.titleInfoDarkStyle,
    ),

    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryBlue,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
      error: AppColors.errorRed,
    ),
  );
}
