// display_image_page.dart

import 'dart:io';

import 'package:flutter/material.dart';

class UploadLifeStyle extends StatelessWidget {
  final String imagePath;

  const UploadLifeStyle({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.white,),
        ),
      backgroundColor: Colors.black,
        
      ),
      body: Center(
        child: Image.file(File(
            imagePath)), // Assuming imagePath is the path to the selected image
      ),
    );
  }
}
