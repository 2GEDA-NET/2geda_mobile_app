import 'package:flutter/material.dart';

class TvScreen extends StatelessWidget{
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Screen'),
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
