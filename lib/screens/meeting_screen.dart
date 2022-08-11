import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/join_room_screen.dart';
import 'package:zoom_clone/screens/video_call_screen.dart';
import 'package:zoom_clone/services/webrtc_communication_methods.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  // final WebRTCCommunicationMethods _webRTCCommunicationMethods =
  //     WebRTCCommunicationMethods();

  createNewMeeting(BuildContext context) async {
    //var random = Random();
    //String roomName = (random.nextInt(10000000) + 10000000).toString();
    // roomName = await _webRTCCommunicationMethods.createRoom(
    //   roomName: roomName,
    // );
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const VideoCallScreen();
    }));
  }

  joinMeeting(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const JoinRoomScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () => createNewMeeting(context),
              text: 'New Meeting',
              icon: Icons.videocam,
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              text: 'Join Meeting',
              icon: Icons.add_box_rounded,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: 'Schedule',
              icon: Icons.calendar_today,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: 'Share Screen',
              icon: Icons.arrow_upward_rounded,
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with just a click!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
