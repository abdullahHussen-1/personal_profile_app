import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/network/token_storage.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        bool isToken = await TokenStorage.exists();
        if (isToken) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeBottomScreen);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: AppMediaQuery.sizeHeight(context) * 0.04,
                horizontal: AppMediaQuery.sizeWidth(context) * 0.07,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 80, color: Colors.white),
            ).animate().fade(duration: 800.ms).scale(delay: 200.ms),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.03),

            Text(
              "Personal Profile",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w900,
              ),
            ).animate().fade(delay: 500.ms).slideY(begin: 0.5, end: 0),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
            Text(
              "Your identity, simplified",
              style: Theme.of(context).textTheme.bodySmall,
            ).animate().fade(delay: 800.ms),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.06),

            CircularProgressIndicator(
              strokeWidth: 5,
              color: Theme.of(context).primaryColor,
            ).animate().fade(delay: 1200.ms),
          ],
        ),
      ),
    );
  }
}
