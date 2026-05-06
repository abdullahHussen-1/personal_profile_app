import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_colors.dart';
import 'package:personal_profile_app/screens/gallery/gallery_shimmer.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

import '../../core/themes/app_media_query.dart';
import '../../features/gallery/models/gallery_models.dart';
import '../../features/gallery/services/gallery_service.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<String> images = [];
  final GalleryService _galleryService = GalleryService();
  List<GalleryImageModel> galleryImages = [];
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickGalleryImages(ImageSource source) async {
    List<String> selectedPaths = [];

    try {
      if (source == ImageSource.gallery) {
        final List<XFile> pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles.isNotEmpty) {
          selectedPaths = pickedFiles.map((file) => file.path).toList();
        }
      } else {
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
        );
        if (photo != null) {
          selectedPaths = [photo.path];
        }
      }

      if (selectedPaths.isNotEmpty) {
        uploadGalleryImages(selectedPaths);
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

  void initState() {
    super.initState();
    _fetchGalleryData();
  }

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
      body: isLoading
          ? GalleryShimmer()
          : galleryImages.isEmpty
          ? Center(
              child: Text(
                "Your gallery is empty. Start adding some memories!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
            )
          : GridView.builder(
              padding: EdgeInsets.all(AppMediaQuery.sizeWidth(context) * 0.04),
              itemCount: galleryImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      AppRoutes.galleryDetailsScreen,
                      arguments: galleryImages[index],
                    );
                    _fetchGalleryData();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: CachedNetworkImage(
                        imageUrl: galleryImages[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
      floatingActionButton:
          FloatingActionButton.extended(
            onPressed: _showPickerOptions,
            label: const Text(
              "Add Images",
              style: TextStyle(color: AppColors.white),
            ),
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ).animate().scale(
            delay: 400.ms,
            duration: 500.ms,
            curve: Curves.fastOutSlowIn,
          ),
    );
  }

  Future<void> _fetchGalleryData() async {
    try {
      final response = await _galleryService.getAll();
      if (response.success) {
        setState(() {
          galleryImages = response.data ?? [];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        DialogUtils.showMessage(
          context: context,
          message: response.message ?? "Error loading profile",
          actions: [
            IconButton(
              onPressed: () {
                _fetchGalleryData();
                Navigator.pop(context);
              },
              icon: Text("OK"),
            ),
          ],
          title: "Error",
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Gallery'),
              onTap: () {
                _pickGalleryImages(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _pickGalleryImages(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadGalleryImages(List<String> imagePaths) async {
    DialogUtils.showLoading(
      context: context,
      text: "Uploading images to gallery...",
    );

    try {
      final response = await _galleryService.uploadImages(imagePaths);
      if (mounted) DialogUtils.hideLoading(context: context);

      if (response.success) {
        if (mounted) {
          DialogUtils.showMessage(
            context: context,
            message: "Images added to gallery successfully!",
            title: "Success",
          );

          _fetchGalleryData();
        }
      } else {
        if (mounted) {
          DialogUtils.showMessage(
            context: context,
            message: response.message ?? "Failed to upload images",
            title: "Error",
          );
        }
      }
    } catch (e) {
      if (mounted) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "Connection Error: Please check your internet",
          title: "Error",
        );
      }
    }
  }
}
