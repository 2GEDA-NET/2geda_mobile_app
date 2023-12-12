import 'package:flutter/material.dart';

class ProfileSqrBtns extends StatelessWidget {
  String? meter;
  String? title;
  ProfileSqrBtns({super.key, this.meter, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 50,
      decoration: ShapeDecoration(
        color: const Color(0xFF4F0DA3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? 'Stickers',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFFF5F5F5),
              fontSize: 10,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            meter ?? '18m',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFFF5F5F5),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
