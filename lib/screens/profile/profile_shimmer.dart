import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_circle_avatar.dart';
import 'package:personal_profile_app/core/widgets/custom_elevated_button.dart';
import 'package:personal_profile_app/core/widgets/custom_menu_Card.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color baseColor = isDark
        ? Theme.of(context).cardColor
        : Colors.grey[300]!;
    final Color highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
          vertical: AppMediaQuery.sizeHeight(context) * 0.02,
        ),
        child: Column(
          children: [
            CustomCircleAvatar(),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),

            Container(
              width: 180,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.04),
            CustomMenuCard(
              title: "Loading...",
              iconData: Icons.circle,
              value: "Loading data...",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            CustomMenuCard(
              title: "Loading...",
              iconData: Icons.circle,
              value: "Loading data...",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            CustomMenuCard(
              title: "Loading...",
              iconData: Icons.circle,
              value: "Loading data...",
              onTap: () {},
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),
            CustomElevatedButton(
              text: "Loading",
              backGroundColor: Colors.white,
              widthContainer: double.infinity,
              heightContainer: 55,
            ),
          ],
        ),
      ),
    );
  }
}
