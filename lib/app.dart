import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/theme.dart';
import 'package:personal_profile_app/screens/gallery_screen.dart';
import 'package:personal_profile_app/screens/home_bottom_navigation_bar.dart';
import 'package:personal_profile_app/screens/home_screen.dart';
import 'package:personal_profile_app/screens/logout_screen.dart';
import 'package:personal_profile_app/screens/profile_screen.dart';
import 'package:personal_profile_app/screens/settings_screen.dart';
import 'package:personal_profile_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Personal Profile App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.homeBottomScreen,
      routes: {
        AppRoutes.splashScreen: (context) => SplashScreen(),
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.galleryScreen: (context) => GalleryScreen(),
        AppRoutes.settingsScreen: (context) => SettingsScreen(),
        AppRoutes.profileScreen: (context) => ProfileScreen(),
        AppRoutes.homeBottomScreen: (context) => HomeBottomNavigationBar(),
        AppRoutes.logoutScreen: (context) => LogoutScreen(),
      },
    );
  }
}
