import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  String? hintTxt;
  TextEditingController controller;
  SearchField({super.key, this.hintTxt, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: const Icon(Icons.search),
        hintText: hintTxt ?? '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
