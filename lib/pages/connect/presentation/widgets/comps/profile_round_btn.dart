import 'package:_2geda/utils/constant/app_color.dart';
import 'package:flutter/material.dart';

class ProfileRoundBtns extends StatelessWidget {
  Color? color;
  String? content;
  ProfileRoundBtns({super.key, this.color, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162.22,
      height: 41.28,
      decoration: ShapeDecoration(
        color: color ?? kPrimary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          content ?? 'Chat',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }
}
