import 'dart:io';

import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  CustomCircleAvatar({super.key, this.imageFile, this.imageUrl});

  File? imageFile;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 53,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(radius: 50, backgroundImage: image()),
    );
  }

  ImageProvider image() {
    if (imageUrl != null &&
        imageUrl!.isNotEmpty &&
        imageUrl!.startsWith('http')) {
      return NetworkImage(imageUrl!);
    }

    if (imageFile != null) {
      return FileImage(imageFile!);
    }

    return const AssetImage('assets/images/null_image.jpeg');
  }
}
