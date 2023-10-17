// account_screen.dart

import 'package:flutter/material.dart';

class VotingScreen extends StatelessWidget{
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting Screen'),
      ),
      body: const Center(
        child: Text('Account Screen Content'),
      ),
    );
  }
}
