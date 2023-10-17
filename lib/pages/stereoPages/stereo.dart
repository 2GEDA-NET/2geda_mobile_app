// account_screen.dart

import 'package:flutter/material.dart';

class StereoScreen extends StatelessWidget{
  const StereoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stereo Screen'),
      ),
      body: const Center(
        child: Text('Account Screen Content'),
      ),
    );
  }
}
