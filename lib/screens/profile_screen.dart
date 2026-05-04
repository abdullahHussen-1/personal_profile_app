import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_circle_avatar.dart';
import 'package:personal_profile_app/core/widgets/custom_elevated_button.dart';
import 'package:personal_profile_app/core/widgets/custom_menu_Card.dart';
import 'package:personal_profile_app/features/auth/models/auth_models.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

import '../features/profile/services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService profileService = ProfileService();
  UserModel? user;
  bool isLoading = true;

  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
          vertical: AppMediaQuery.sizeHeight(context) * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircleAvatar()
                .animate()
                .fadeIn(duration: 900.ms)
                .slideY(begin: -0.2, end: 0),
            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
            Text(
              user!.fullName ?? "null",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.04),

            CustomMenuCard(
              title: "Email",
              iconData: Icons.email_outlined,
              onTap: () {},
              value: user!.email ?? "null",
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),

            CustomMenuCard(
              title: "Phone",
              iconData: Icons.phone_android_outlined,
              onTap: () {},
              value: user!.phone ?? "null",
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),

            CustomMenuCard(
              title: "Bio",
              iconData: Icons.info_outline,
              onTap: () {},
              value: user!.bio ?? "null",
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),
            SizedBox(
              width: double.infinity,
              height: AppMediaQuery.sizeHeight(context) * 0.1,
              child: CustomElevatedButton(
                text: "Edit Profile",
                backGroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editScreen);
                },
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
          ],
        ),
      ),
    );
  }

  Future<void> fetchProfile() async {
    try {
      final response = await profileService.getProfile();
      if (response.success && response.data != null) {
        setState(() {
          user = response.data;
          isLoading = false;
        });
      } else {
        if (mounted) {
          DialogUtils.showMessage(
            context: context,
            message: response.message ?? "Error loading profile",
          );
        }
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
