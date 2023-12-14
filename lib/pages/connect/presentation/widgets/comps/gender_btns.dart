import 'package:flutter/material.dart';

class GenderBtns extends StatelessWidget {
  String? titl;
  Color? color;
  Color? txtColor;
  final Function()? onPressed;
  GenderBtns({super.key, this.color, this.onPressed, this.titl, this.txtColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 119,
        height: 35,
        decoration: ShapeDecoration(
          color: color ?? const Color(0xFF4E0CA2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
