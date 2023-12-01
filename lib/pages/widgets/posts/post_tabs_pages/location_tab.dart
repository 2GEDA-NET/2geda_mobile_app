import 'package:flutter/material.dart';

class LocationTabContent extends StatelessWidget {
  final int currentIndex; // Add this line

  const LocationTabContent({
    Key? key,
    required this.currentIndex, // Add this parameter
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Location Tab Content')
        ],
    );
  }
}
