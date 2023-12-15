import 'package:flutter/material.dart';

class ProductsTabContent extends StatelessWidget {
  final int currentIndex; // Add this line

  const ProductsTabContent({
    Key? key,
    required this.currentIndex, // Add this parameter
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Product Tab Content')
        ],
    );
  }
}
