import 'package:_2geda/pages/chatPages/callScreens/video_call_page.dart';
import 'package:flutter/material.dart';

const appId = "5629e2f1eac04cdaa8fbce5f0afd1466";

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Conversation Screen'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AudioCallScreen(agoraAppId: appId,),
              //     // builder: (context) => VideoChatScreen(),
              //   ),
              // );
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => VideoCallPage(),
              //   ),
              // );
            },
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: const Center(
        child: Text('Account Screen Content'),
      ),
    );
  }
}
