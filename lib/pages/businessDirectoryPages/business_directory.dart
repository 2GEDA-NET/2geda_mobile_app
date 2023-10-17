// account_screen.dart

import 'package:flutter/material.dart';

class BusinessDirectory extends StatelessWidget{
  const BusinessDirectory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Directory'),
      ),
      body: const Center(
        child: Text('Account Screen Content'),
      ),
    );
  }
}
