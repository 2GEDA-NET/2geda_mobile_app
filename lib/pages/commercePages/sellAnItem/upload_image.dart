// account_screen.dart
import 'dart:io';
import 'package:_2geda/pages/commercePages/sellAnItem/product_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImageUpload extends StatelessWidget {

  const ProductImageUpload({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Upload Images',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.shop),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text("You can add up to 5 images",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "The first image is the cover image",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ImageUploadFrame(
                frameHeight: 200,
                frameWidth: MediaQuery.of(context).size.width,
              ),
              Row(
                children: [
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                  Expanded(
                    child: ImageUploadFrame(
                      frameHeight: 70,
                      frameWidth: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffe3c0ff),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Read image upload Guidelines",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 17,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPreviewPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Move to step 2",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageUploadFrame extends StatefulWidget {
  final double frameHeight;
  final double frameWidth;

  ImageUploadFrame({required this.frameHeight, required this.frameWidth});

  @override
  _ImageUploadFrameState createState() => _ImageUploadFrameState();
}

class _ImageUploadFrameState extends State<ImageUploadFrame> {
  XFile? selectedImage;

  Future<void> onImageSelected() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.frameWidth,
      height: widget.frameHeight,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: onImageSelected, // Invoke the function when tapped
        child: Center(
          child: selectedImage == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: widget.frameHeight * 0.40,
                      color: Colors.grey,
                    ),
                  ],
                )
              : Image.file(
                  File(selectedImage!.path),
                  width: widget.frameWidth,
                  height: widget.frameHeight,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
