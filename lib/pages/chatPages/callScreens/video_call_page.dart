import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';

const appId = "5629e2f1eac04cdaa8fbce5f0afd1466";


class VideoCallPage extends StatefulWidget {
  VideoCallPage({Key? key}) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  // Create UI with local view and remote view
  final AgoraClient _client = AgoraClient(
    agoraConnectionData:
        AgoraConnectionData(appId: appId, channelName: '2GEDAchannel', tempToken: '4d86e24f647f4560bd8206e25f2ab144'),
  );

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await _client.initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          AgoraVideoViewer(client: _client, layoutType: Layout.floating, showNumberOfUsers: true,),
          AgoraVideoButtons(client: _client, enabledButtons: [BuiltInButtons.toggleCamera, BuiltInButtons.switchCamera, BuiltInButtons.toggleMic, BuiltInButtons.screenSharing, BuiltInButtons.callEnd,],),
          const Center(
              // child: _remoteVideo(),
              ),
          const Align(alignment: Alignment.topLeft, child: SizedBox()),
        ],
      ),
    );
  }
}
