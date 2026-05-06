import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.07,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: AppMediaQuery.sizeHeight(context) * 0.05,
                horizontal: AppMediaQuery.sizeWidth(context) * 0.07,
              ),
              margin: EdgeInsetsGeometry.symmetric(
                vertical: AppMediaQuery.sizeHeight(context) * 0.03,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 80, color: Colors.white),
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),

            Text(
              "Personal Profile App",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "Version 1.0.0",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),

            Text(
              "This app is built with Flutter to help you manage your personal information and memories.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Team",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
            Text(
              "Abdullah Hussein",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Team Flutter",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Open Source Community",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.08),

            Text(
              "© 2024 All Rights Reserved",
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
    );
  }
}
