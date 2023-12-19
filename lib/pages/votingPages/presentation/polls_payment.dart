import 'package:flutter/material.dart';

class PollPaymentScreen extends StatelessWidget {
  const PollPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Payment',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/2geda-purple.png'),
            ),
          ],
        ),
        body: Column(
          children: [],
        ));
  }
}
