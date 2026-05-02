import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/theme.dart';
import 'package:personal_profile_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Profile App',
      theme: AppTheme.darkTheme,
      home: SplashScreen(),
    );
  }
}
