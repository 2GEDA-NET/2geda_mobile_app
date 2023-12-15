import 'package:flutter/material.dart';

class ImagesTabContent extends StatelessWidget {
  final int currentIndex; // Add this line

  const ImagesTabContent({
    Key? key,
    required this.currentIndex, // Add this parameter
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Images Tab Content')
        ],
    );
  }
}
