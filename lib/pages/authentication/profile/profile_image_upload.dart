import 'dart:io';

import 'package:_2geda/APIServices/authentication_api_services.dart';
import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key}) : super(key: key);

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

final apiService = AuthenticationApiService();

class _ImageUploadPageState extends State<ImageUploadPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _coverImage;
  XFile? _profileImage;

  final token = TokenManager().getToken();

Future<void> _uploadProfileImage() async {
  if (_profileImage != null) {
    final imagePath = _profileImage!.path;
    
    final String? token = await TokenManager().getToken();

    if (token != null) {
      final response = await apiService.uploadProfileImage(token, imagePath);
      print(response.body);

      if (response.statusCode == 200) {
        // Image uploaded successfully
        // Handle success, e.g., navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SideBarLayout()),
        );
      } else {
        // Handle upload failure, display an error message, or retry
      }
    } else {
      // Handle the case where the token is null or couldn't be obtained
    }
  }
}

  Future<void> _pickImage(ImageSource source, bool isCoverImage) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          if (isCoverImage) {
            _coverImage = pickedImage;
          } else {
            _profileImage = pickedImage;
          }
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0x33d9d9d9),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/2geda-purple.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Set profile picture",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  )),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  _buildImageFrame(
                    isCoverImage: true,
                    text: "Add Cover Image",
                    image: _coverImage,
                  ),
                  Positioned(
                    top: 100,
                    child: _buildProfileImageFrame(
                      isProfileImage: true,
                      image: _profileImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Images must clearly show your face, blurry images will not be approved!",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Logos and designs that do not correlate with the profile data and purpose will not be approved also.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              TextButton(
                onPressed: () {
                  // Handle the "Skip" action
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SideBarLayout()),
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle the "Continue" action
                  _uploadProfileImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageFrame({
    required bool isCoverImage,
    required String text,
    XFile? image,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image != null)
            Image.file(
              File(image.path),
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          if (image == null)
            Positioned(
              top:
                  0, // Adjust the top value to control the purple content's position
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xff4e0ca2),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery, isCoverImage);
                      },
                      icon: const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            // top: 20,
            right: 0,
            bottom: 23,
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery, isCoverImage);
              },
              child: Container(
                width: 30, // Adjust the width
                height: 30, // Adjust the height
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 15,
                    color: Colors.white, // Optional: Change icon color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImageFrame({
    required bool isProfileImage,
    XFile? image,
  }) {
    return Container(
      width: 100, // Set the width to match the image size
      height: 100, // Set the height to match the image size
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image != null)
            ClipOval(
              child: Image.file(
                File(image.path),
                width: 100, // Set the width to match the container size
                height: 100, // Set the height to match the container size
                fit: BoxFit.cover,
              ),
            ),
          if (image == null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/avatar.png')],
            ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery, false);
              },
              child: Container(
                width: 30, // Adjust the width
                height: 30, // Adjust the height
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white, // Optional: Change icon color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
