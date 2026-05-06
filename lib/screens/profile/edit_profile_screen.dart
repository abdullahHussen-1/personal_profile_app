import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_circle_avatar.dart';
import 'package:personal_profile_app/core/widgets/custom_text_form_field.dart';
import 'package:personal_profile_app/features/auth/models/auth_models.dart';
import 'package:personal_profile_app/features/profile/services/profile_service.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

import '../../core/widgets/custom_elevated_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ProfileService profileService = ProfileService();
  late UserModel user;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      uploadAvatar(pickedFile.path);
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
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    emailController.text = user.email;
    nameController.text = user.fullName;
    phoneController.text = user.phone;
    bioController.text = user.bio;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
          vertical: AppMediaQuery.sizeHeight(context) * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  CustomCircleAvatar(
                    imageFile: imageFile,
                    imageUrl: user.avatarUrl,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        _showPickerOptions();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: nameController,
                    label: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: phoneController,
                    label: "Phone",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: bioController,
                    label: "Bio",
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your bio';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),

            SizedBox(
              width: double.infinity,
              height: AppMediaQuery.sizeHeight(context) * 0.09,
              child: CustomElevatedButton(
                text: "Save Changes",
                backGroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  //todo=>save data change
                  saveChangeData();
                },
              ),
            ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
          ],
        ),
      ),
    );
  }

  Future<void> saveChangeData() async {
    if (_formKey.currentState!.validate()) {
      DialogUtils.showLoading(context: context, text: "Saving changes...");

      try {
        final response = await profileService.updateProfile(
          fullName: nameController.text,
          phone: phoneController.text,
          bio: bioController.text,
          email: emailController.text,
        );

        if (mounted) DialogUtils.hideLoading(context: context);

        if (response.success) {
          if (mounted) {
            DialogUtils.showMessage(
              context: context,
              message: "Profile updated successfully!",
              title: "Success",
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(this.context).pop(true);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
            //Navigator.pop(context);
          }
        } else {
          if (mounted) {
            DialogUtils.showMessage(
              context: context,
              message: response.message ?? "Update failed",
              title: "Error",
            );
          }
        }
      } catch (e) {
        if (mounted) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: "Connection Error",
          );
        }
      }
    }
  }

  Future<void> uploadAvatar(String base64Image) async {
    DialogUtils.showLoading(
      context: context,
      text: "Updating profile picture...",
    );

    try {
      final response = await profileService.uploadAvatar(base64Image);

      if (mounted) DialogUtils.hideLoading(context: context);

      if (response.success) {
        if (mounted) {
          DialogUtils.showMessage(
            context: context,
            message: "Profile picture updated successfully!",
          );
        }
      } else {
        if (mounted) {
          DialogUtils.showMessage(
            context: context,
            message: response.message ?? "Failed to upload image",
            title: "Error",
          );
        }
      }
    } catch (e) {
      if (mounted) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "Connection Error",
          title: "Error",
        );
      }
    }
  }
}
