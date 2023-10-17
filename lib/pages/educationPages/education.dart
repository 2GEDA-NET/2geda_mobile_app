// account_screen.dart

import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget{
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Screen'),
      ),
      body: const Center(
        child: Text('Account Screen Content'),
      ),
    );
  }
}
