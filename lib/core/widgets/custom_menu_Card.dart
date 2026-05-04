import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';

class CustomMenuCard extends StatelessWidget {
  String title;
  String value;
  IconData iconData;
  void Function()? onTap;
  bool isLogout;
  bool isInfo;

  CustomMenuCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
    this.isLogout = false,
    this.isInfo = true,
    this.value = "",
  });

  @override
  Widget build(BuildContext context) {
    return isInfo
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: AppMediaQuery.sizeHeight(context) * 0.02,
                horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      iconData,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: AppMediaQuery.sizeWidth(context) * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          value,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
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
