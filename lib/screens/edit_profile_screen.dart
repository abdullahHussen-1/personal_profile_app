import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_circle_avatar.dart';
import 'package:personal_profile_app/core/widgets/custom_text_form_field.dart';

import '../core/widgets/custom_elevated_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  final nameController = TextEditingController(text: "Abdullah Hussein");
  final emailController = TextEditingController(text: "abdullah@gmail.com");
  final phoneController = TextEditingController(text: "+20 100 123 4567");
  final bioController = TextEditingController(
    text:
        "Passionate Flutter Developer who loves building beautiful mobile apps.",
  );
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
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
                  CustomCircleAvatar(imageFile: imageFile),
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

  void saveChangeData() {
    if (_formKey.currentState!.validate()) {
      print("Validated!");
    }
  }
}
