import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/themes/app_media_query.dart';

class GalleryDetailsScreen extends StatefulWidget {
  GalleryDetailsScreen({super.key});

  @override
  State<GalleryDetailsScreen> createState() => _GalleryDetailsScreenState();
}

class _GalleryDetailsScreenState extends State<GalleryDetailsScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var imageUrl = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Image Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(AppMediaQuery.sizeWidth(context) * 0.04),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  imageUrl ?? "",
                  width: double.infinity,
                  height: AppMediaQuery.sizeHeight(context) * 0.45,
                  fit: BoxFit.cover,
                ),
              ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Beautiful Nature",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? Colors.red
                          : Theme.of(context).iconTheme.color,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
                vertical: 10,
              ),
              child: Text(
                "This is a beautiful place I visited last summer. The view was amazing and very peaceful.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "12 May 2024",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
