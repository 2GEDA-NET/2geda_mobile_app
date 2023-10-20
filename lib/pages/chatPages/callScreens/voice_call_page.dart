// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// const appId = "5629e2f1eac04cdaa8fbce5f0afd1466";



// class AudioCallScreen extends StatefulWidget {
//   final String agoraAppId;

//   AudioCallScreen({required this.agoraAppId});

//   @override
//   _AudioCallScreenState createState() => _AudioCallScreenState();
// }

// class _AudioCallScreenState extends State<AudioCallScreen> {
//   RtcEngine? _rtcEngine;

//   @override
//   void initState() {
//     super.initState();
//     initializeAgora();
//     joinChannel();
//   }

//   void initializeAgora() async {
//     _rtcEngine = await RtcEngine.create(widget.agoraAppId);
//     _rtcEngine?.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//           // Handle join channel success
//         },
//         // Add more event handlers here
//       ),
//     );
//   }

//   void joinChannel() async {
//     await _rtcEngine?.joinChannel(null, 'your_channel_id', null, 0);
//   }

//   @override
//   void dispose() {
//     _rtcEngine?.leaveChannel();
//     _rtcEngine?.destroy();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Call'),
//       ),
//       body: Center(
//         child: Text('You are in an audio call.'),
//       ),
//     );
//   }
// }
