import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_circle_avatar.dart';
import 'package:personal_profile_app/core/widgets/custom_menu_Card.dart';
import 'package:personal_profile_app/screens/home/home_bottom_navigation_bar.dart';
import 'package:personal_profile_app/screens/home/home_shimmer.dart';

import '../../features/auth/models/auth_models.dart';
import '../../features/profile/services/profile_service.dart';
import '../../utils/dialog_utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            onPressed: () {
              //todo=>Navigator to Notification
              Navigator.pushNamed(context, AppRoutes.notificationsScreen);
            },
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: isLoading
          ? HomeShimmer()
          : SingleChildScrollView(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.02,
                vertical: AppMediaQuery.sizeHeight(context) * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: AppMediaQuery.sizeHeight(context) * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CustomCircleAvatar(imageUrl: user!.avatarUrl),
                            SizedBox(
                              height: AppMediaQuery.sizeHeight(context) * 0.015,
                            ),
                            Text(
                              user!.fullName,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              height: AppMediaQuery.sizeHeight(context) * 0.005,
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 900.ms)
                      .slideY(begin: -0.2, end: 0),
                  SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      CustomMenuCard(
                        title: 'View Profile',
                        iconData: Icons.person_outline,
                        onTap: () {
                          HomeBottomNavigationBar.navKey.currentState
                              ?.updateIndex(3);
                        },
                        isInfo: false,
                      ),
                      CustomMenuCard(
                        title: 'Gallery',
                        iconData: Icons.image_outlined,
                        onTap: () {
                          HomeBottomNavigationBar.navKey.currentState
                              ?.updateIndex(1);
                        },
                        isInfo: false,
                      ),
                      CustomMenuCard(
                        title: 'Settings',
                        iconData: Icons.settings_outlined,
                        onTap: () {
                          HomeBottomNavigationBar.navKey.currentState
                              ?.updateIndex(2);
                        },
                        isInfo: false,
                      ),
                      CustomMenuCard(
                        title: 'Logout',
                        iconData: Icons.logout,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.logoutScreen);
                        },
                        isLogout: true,
                        isInfo: false,
                      ),
                    ],
                  ),
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
            actions: [
              IconButton(
                onPressed: () {
                  fetchProfile();
                  Navigator.pop(context);
                },
                icon: Text("OK"),
              ),
            ],
            title: "Error",
          );
        }
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
