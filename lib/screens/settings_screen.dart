import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../core/themes/theme_provider.dart';
import '../core/widgets/custom_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomListTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              iconColor: Colors.blue,
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (v) {
                  themeProvider.changeTheme(v);
                },
              ),
            ),
            CustomListTile(
              icon: Icons.notifications_none_outlined,
              title: "Notifications",
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.notificationsScreen);
              },
            ),
            CustomListTile(
              icon: Icons.info_outline,
              title: "About",
              iconColor: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.aboutScreen);
              },
            ),
            CustomListTile(
              icon: Icons.lock,
              title: "Privacy",
              iconColor: Colors.indigo,
              onTap: () {},
            ),
            CustomListTile(
              icon: Icons.mail_outline,
              title: "Contact Us",
              iconColor: Colors.blueGrey,
              onTap: () {},
            ),
          ],
        ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
      ),
    );
  }
}
