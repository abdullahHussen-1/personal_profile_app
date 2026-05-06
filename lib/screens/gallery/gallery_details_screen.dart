import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

import '../../core/themes/app_media_query.dart';
import '../../features/gallery/models/gallery_models.dart';
import '../../features/gallery/services/gallery_service.dart';

class GalleryDetailsScreen extends StatefulWidget {
  GalleryDetailsScreen({super.key});

  @override
  State<GalleryDetailsScreen> createState() => _GalleryDetailsScreenState();
}

class _GalleryDetailsScreenState extends State<GalleryDetailsScreen> {
  final GalleryService _galleryService = GalleryService();
  bool isFavorite = false;
  bool isActionLoading = false; // لمنع الضغط المتكرر أثناء التحميل

  @override
  void initState() {
    super.initState();
    // تأجيل الحصول على البيانات حتى تكتمل عملية بناء الـ Context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFavoriteStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    var imageModel =
        ModalRoute.of(context)?.settings.arguments as GalleryImageModel;
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
                child: Image.network(
                  imageModel.imageUrl ?? "",
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
                    "Special Moment",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _toggleFavorite(imageModel.id);
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
                "Capturing this beautiful moment to stay forever. Every detail here brings back a sense of peace and great memories.",
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
                    "${formatDate(imageModel.createdAt)}",
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

  String formatDate(dynamic date) {
    if (date == null) return "N/A";
    try {
      DateTime? dateTime;
      if (date is DateTime) {
        dateTime = date;
      } else if (date is String && date.isNotEmpty) {
        dateTime = DateTime.parse(date);
      }
      if (dateTime != null) {
        return DateFormat('d MMM yyyy').format(dateTime);
      }
      return "N/A";
    } catch (e) {
      return "Invalid Date";
    }
  }

  Future<void> _toggleFavorite(int id) async {
    if (isActionLoading) return;
    setState(() {
      isFavorite = !isFavorite;
      isActionLoading = true;
    });

    try {
      final response = !isFavorite
          ? await _galleryService.removeFavorite(id)
          : await _galleryService.addFavorite(id);

      if (!response.success) {
        setState(() {
          isFavorite = !isFavorite;
        });
        if (mounted) {
          DialogUtils.showMessage(
            context: context,
            message: response.message ?? "Error",
          );
        }
      }
    } catch (e) {
      setState(() {
        isFavorite = !isFavorite;
      });
      if (mounted) {
        DialogUtils.showMessage(
          context: context,
          message: "Something went wrong",
        );
      }
    } finally {
      if (mounted) setState(() => isActionLoading = false);
    }
  }

  void _initializeFavoriteStatus() {
    final imageModel =
        ModalRoute.of(context)?.settings.arguments as GalleryImageModel;
    setState(() {
      isFavorite = imageModel.isFavorite ?? false;
    });
  }
}
