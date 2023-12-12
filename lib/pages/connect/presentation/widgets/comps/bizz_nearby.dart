import 'package:flutter/material.dart';

class BusnessNearbyWidget extends StatelessWidget {
  const BusnessNearbyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFFF8A15),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Color(0xFF4F0DA3)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
