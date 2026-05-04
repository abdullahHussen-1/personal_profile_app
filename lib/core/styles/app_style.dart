import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';

class AppStyle {
  static TextStyle titleDarkStyle = TextStyle(
    color: AppColors.darkTextPrimary,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleLightStyle = TextStyle(
    color: AppColors.lightTextPrimary,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleInfoLightStyle = TextStyle(
    color: AppColors.darkBackground,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleInfoDarkStyle = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
