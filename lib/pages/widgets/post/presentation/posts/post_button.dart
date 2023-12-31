import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const PostButton({super.key, 
    required this.icon,
    required this.label,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onLongPress: onLongPress,
            child: IconButton(onPressed: onTap, icon: icon),
          ),
          Text(label),
        ],
      ),
    );
  }
}
