import 'package:flutter/material.dart';


void main() {
  runApp(const MaterialApp(
    home: ConnectScreen(),
  ));
}


class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Connect Screen!',
              style: TextStyle(fontSize: 24),
            ),
            // Add your Connect Screen content here...
          ],
        ),
      ),
    );
  }
}
