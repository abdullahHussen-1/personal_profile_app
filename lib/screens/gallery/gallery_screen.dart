import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';

import '../../core/themes/app_media_query.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final List<String> images = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(AppMediaQuery.sizeWidth(context) * 0.04),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.galleryDetailsScreen,
                arguments: images[index],
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Image.network(images[index], fit: BoxFit.cover),
              ),
            ),
          );
        },
      ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
    );
  }
}
