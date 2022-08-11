import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:zoom_clone/services/webrtc_communication_methods.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key, this.roomId}) : super(key: key);
  final String? roomId;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  WebRTCCommunicationMethods webRTCCommunicationMethods =
      WebRTCCommunicationMethods();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _localRenderer.initialize();
      await _remoteRenderer.initialize();
      await webRTCCommunicationMethods.openUserMedia(
          _localRenderer, _remoteRenderer);
      roomId = widget.roomId;
      if (roomId == null || roomId!.isEmpty) {
        webRTCCommunicationMethods.createRoom().then((value) {
          setState(() {
            roomId = value;
          });
        });
      } else {
        webRTCCommunicationMethods.joinRoom(
            roomId: widget.roomId!, username: "");
      }

      webRTCCommunicationMethods.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText("Room Id - ${roomId ?? 'Making...'}"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await webRTCCommunicationMethods.hangUp();
                  Navigator.of(context).pop();
                },
                child: const Text("Hangup"),
              )
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
