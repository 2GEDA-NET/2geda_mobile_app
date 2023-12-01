import 'package:flutter/material.dart';

class VideosTabContent extends StatelessWidget {
  final int currentIndex; // Add this line

  const VideosTabContent({
    Key? key,
    required this.currentIndex, // Add this parameter
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Videos Tab Content')
        ],
    );
  }
}
