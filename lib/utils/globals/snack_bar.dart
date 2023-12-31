import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, Color bgColor, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 5), // Adjust the duration as needed
      backgroundColor: bgColor, // Set the background color
    ),
  );
}
