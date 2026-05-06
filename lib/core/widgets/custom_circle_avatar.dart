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
      child: CircleAvatar(
        radius: 50,
        backgroundImage: imageFile != null
            ? FileImage(imageFile!)
            : imageUrl != null
            ? NetworkImage(imageUrl!)
            : AssetImage('assets/images/null_image.jpeg'),
      ),
    );
  }
}
