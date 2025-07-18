import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doctor_apk/view_model/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// const appId = "<-- Insert App Id -->";
// const token = "<-- Insert Token -->";
// const channel = "<-- Insert Channel Name -->";
//


class VideoStream extends StatefulWidget {
  final String channelName;
  const VideoStream({Key? key,required this.channelName}) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _videoOff = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    final data = Provider.of<TokenViewModel>(context, listen: false).modelData;
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "fd627d26d7264a1ba0b12b6125e3250f",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: data?.token??"",
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }
  Widget _toolbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _controlButton(
              icon: _muted ? Icons.mic_off : Icons.mic,
              color: _muted ? Colors.red : Colors.white,
              onTap: () {
                setState(() {
                  _muted = !_muted;
                  _engine.muteLocalAudioStream(_muted);
                  print(_engine.muteLocalAudioStream(_muted));
                  print("aman");
                } );
              },
            ),
            const SizedBox(width: 12),
            _controlButton(
              icon: _videoOff ? Icons.videocam_off : Icons.videocam,
              color: _videoOff ? Colors.red : Colors.white,
              onTap: () {
                setState(() => _videoOff = !_videoOff);
                _engine.muteLocalVideoStream(_videoOff);
              },
            ),
            const SizedBox(width: 12),
            _controlButton(
              icon: Icons.cameraswitch,
              color: Colors.white,
              onTap: () => _engine.switchCamera(),
            ),
            const SizedBox(width: 12),
            _controlButton(
              icon: Icons.call_end,
              color: Colors.red,
              onTap: () {
                _engine.leaveChannel();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _controlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          _toolbar()
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection:  RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}