import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoChatScreen(),
    );
  }
}

class VideoChatScreen extends StatefulWidget {
  @override
  _VideoChatScreenState createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    initWebRTC();
  }

  void initWebRTC() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    // Initialize WebRTC and create peer connection
    peerConnection = await createPeerConnection({'iceServers': []}, {});
    await createLocalStream();

    // Set up the remote stream event handler
    peerConnection!.onAddStream = (stream) {
      setState(() {
        remoteStream = stream;
        _remoteRenderer.srcObject = remoteStream;
      });
    };
  }

  Future<void> createLocalStream() async {
    final stream = await navigator.mediaDevices.getUserMedia({'video': true, 'audio': true});
    setState(() {
      localStream = stream;
      _localRenderer.srcObject = localStream;
    });
    peerConnection!.addStream(localStream!);
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    peerConnection?.close();
    localStream?.dispose();
    remoteStream?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Chat'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: RTCVideoView(_remoteRenderer),
            ),
            Expanded(
              child: RTCVideoView(_localRenderer),
            ),
          ],
        ),
      ),
    );
  }
}
