// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HalfButton extends StatelessWidget {
  String? titl;
  Color? color;
  Color? txtColor;
  final Function()? onPressed;
  HalfButton({super.key, this.titl, this.color, this.txtColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 189.50,
        height: 36,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: color ?? const Color(0xFF4F0DA3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titl ?? '',
              style: TextStyle(
                color: txtColor ?? Colors.white,
                fontSize: 14,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
