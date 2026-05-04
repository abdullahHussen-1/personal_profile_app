import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/widgets/custom_list_tile.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      "icon": Icons.chat_bubble_outline,
      "title": "New Message",
      "subtitle": "You have received a new message from John.",
      "time": "2m ago",
      "color": Colors.redAccent,
    },
    {
      "icon": Icons.sync,
      "title": "Update Available",
      "subtitle": "A new update is available. Tap to update.",
      "time": "1h ago",
      "color": Colors.blue,
    },
    {
      "icon": Icons.favorite_border,
      "title": "Like Received",
      "subtitle": "Someone liked your profile.",
      "time": "3h ago",
      "color": Colors.pink,
    },
    {
      "icon": Icons.person_outline,
      "title": "App Reminder",
      "subtitle": "Don't forget to complete your profile.",
      "time": "1d ago",
      "color": Colors.orange,
    },
    {
      "icon": Icons.celebration_outlined,
      "title": "Welcome",
      "subtitle": "Thanks for using our app!",
      "time": "2d ago",
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return CustomListTile(
                icon: item['icon'],
                title: item['title'],
                subtitle: item['subtitle'],
                iconColor: item['color'],
                trailing: Text(
                  item['time'],
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () {},
              )
              .animate()
              .fadeIn(delay: (100 * index).ms, duration: 500.ms)
              .slideX(begin: 0.2, end: 0);
        },
      ),
    );
  }
}
