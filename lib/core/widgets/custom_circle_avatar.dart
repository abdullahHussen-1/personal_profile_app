import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 53,
      backgroundColor: AppColors.white,
      child: const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage("assets/images/test_images.jpeg"),
      ),
    );
  }
}
