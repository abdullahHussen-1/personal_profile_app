import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';

class CustomMenuCard extends StatelessWidget {
  String title;
  IconData iconData;
  void Function()? onTap;
  bool isLogout;

  CustomMenuCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, // todo => change theme Mode
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkBackground.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 35,
              color: isLogout
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).primaryColor,
            ),
            SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 1000.ms).slideY(begin: -0.1, end: 0);
  }
}
