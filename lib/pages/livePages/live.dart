import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget{
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Screen'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text('Account Screen Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
