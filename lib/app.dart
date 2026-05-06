import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/theme.dart';
import 'package:personal_profile_app/core/themes/theme_provider.dart';
import 'package:personal_profile_app/screens/about_screen.dart';
import 'package:personal_profile_app/screens/gallery/gallery_details_screen.dart';
import 'package:personal_profile_app/screens/gallery/gallery_screen.dart';
import 'package:personal_profile_app/screens/home/home_bottom_navigation_bar.dart';
import 'package:personal_profile_app/screens/home/home_screen.dart';
import 'package:personal_profile_app/screens/login_screen.dart';
import 'package:personal_profile_app/screens/logout_screen.dart';
import 'package:personal_profile_app/screens/notifications_screen.dart';
import 'package:personal_profile_app/screens/profile/edit_profile_screen.dart';
import 'package:personal_profile_app/screens/profile/profile_screen.dart';
import 'package:personal_profile_app/screens/register_screen.dart';
import 'package:personal_profile_app/screens/settings_screen.dart';
import 'package:personal_profile_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Personal Profile App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.splashScreen: (context) => SplashScreen(),
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.galleryScreen: (context) => GalleryScreen(),
        AppRoutes.settingsScreen: (context) => SettingsScreen(),
        AppRoutes.profileScreen: (context) => ProfileScreen(),
        AppRoutes.homeBottomScreen: (context) => HomeBottomNavigationBar(),
        AppRoutes.logoutScreen: (context) => LogoutScreen(),
        AppRoutes.editScreen: (context) => EditProfileScreen(),
        AppRoutes.galleryDetailsScreen: (context) => GalleryDetailsScreen(),
        AppRoutes.notificationsScreen: (context) => NotificationsScreen(),
        AppRoutes.aboutScreen: (context) => AboutScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.registerScreen: (context) => RegisterScreen(),
      },
    );
  }
}
