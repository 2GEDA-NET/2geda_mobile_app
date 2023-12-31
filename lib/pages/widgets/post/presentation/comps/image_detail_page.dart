import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ImageDetailPage extends StatelessWidget {
  String? eachMedia;
  ImageDetailPage({super.key, required this.eachMedia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.arrow_back_ios_new))),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: InteractiveViewer(
                    child: CachedNetworkImage(imageUrl: eachMedia!)))
          ],
        ),
      ),
    );
  }
}
