// import 'package:doctor_apk/res/color_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// const String appId = "d0a32a9a76bd4e8a9e0a51612f4aa6da";
// const String token = "007eJxTYPBxWBTB5umqcPdVc51Dm9iPpe9Z7pqcLHv/PPnO3r+iX7wVGFIMEo2NEi0Tzc2SUkxSLRItUw0STQ3NDI3STBITzVISt7EWZTQEMjLc+mLEyMgAgSC+MENZalF+Xn5ZYnxKfnJJflF8YkE2AwMA4LEnpw=="; // Or generate dynamically
// const int uid = 0; // 0 means auto-generate
//
// class VideoCallPage extends StatefulWidget {
//   final String channelName;
//
//   const VideoCallPage({Key? key, required this.channelName}) : super(key: key);
//
//   @override
//   State<VideoCallPage> createState() => _VideoCallPageState();
// }
//
// class _VideoCallPageState extends State<VideoCallPage> {
//    RtcEngine ?_engine;
//   int? _remoteUid;
//   bool _joined = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//
//
//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//
//     _engine = createAgoraRtcEngine();
//     await _engine?.initialize(RtcEngineContext(appId: appId));
//
//     _engine?.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           setState(() => _joined = true);
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           setState(() => _remoteUid = remoteUid);
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           setState(() => _remoteUid = null);
//         },
//       ),
//     );
//
//     await _engine?.enableVideo();
//     await _engine?.startPreview();
//     await _engine?.joinChannel(
//       token: token,
//       channelId: widget.channelName,
//       uid: uid,
//       options: const ChannelMediaOptions(),
//     );
//   }
//
//
//   @override
//   void dispose() {
//     _engine?.leaveChannel();
//     _engine?.release();
//     super.dispose();
//   }
//
//   Widget _videoView() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine!,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channelName),
//         ),
//       );
//     } else {
//       return Center(child: Text('Waiting for patient to join...'));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: ColorConstant.lightGrayColor,
//           automaticallyImplyLeading: false,
//           title: Text('Video Call',style: TextStyle(color: ColorConstant.whiteColor),)
//       ),
//       body: Stack(
//         children: [
//           _joined
//               ? _videoView()
//               : Center(child: CircularProgressIndicator()),
//           Positioned(
//             right: 20,
//             bottom: 20,
//             width: 120,
//             height: 160,
//             child: AgoraVideoView(
//               controller: VideoViewController(
//                 rtcEngine: _engine!,
//                 canvas: const VideoCanvas(uid: 0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doctor_apk/res/color_constant.dart';

const String appId = "d0a32a9a76bd4e8a9e0a51612f4aa6da";
const String token = "007eJxTYPBxWBTB5umqcPdVc51Dm9iPpe9Z7pqcLHv/PPnO3r+iX7wVGFIMEo2NEi0Tzc2SUkxSLRItUw0STQ3NDI3STBITzVISt7EWZTQEMjLc+mLEyMgAgSC+MENZalF+Xn5ZYnxKfnJJflF8YkE2AwMA4LEnpw==";
const int uid = 0;

class VideoCallPage extends StatefulWidget {
  final String channelName;

  const VideoCallPage({Key? key, required this.channelName}) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  RtcEngine? _engine;
  int? _remoteUid;
  bool _joined = false;
  bool _muted = false;
  bool _videoOff = false;
  bool _engineInitialized = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine?.initialize(RtcEngineContext(appId: appId));

    _engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() => _joined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() => _remoteUid = null);
        },
      ),
    );

    await _engine?.enableVideo();
    await _engine?.startPreview();
    await _engine?.joinChannel(
      token: token,
      channelId: widget.channelName,
      uid: uid,
      options: const ChannelMediaOptions(),
    );

    setState(() => _engineInitialized = true);
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    _engine?.release();
    super.dispose();
  }

  Widget _videoView() {
    if (!_engineInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine!,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Waiting for patient to join...',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }
  }

  Widget _localPreview() {
    if (!_engineInitialized) return const SizedBox.shrink();

    return Positioned(
      right: 16,
      top: 16,
      width: 120,
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine!,
            canvas: const VideoCanvas(uid: 0),
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    // if (!_joined || !_engineInitialized) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _controlButton(
              icon: _muted ? Icons.mic_off : Icons.mic,
              color: _muted ? Colors.red : Colors.white,
              onTap: () {
                setState(() => _muted = !_muted);
                _engine?.muteLocalAudioStream(_muted);
              },
            ),
            const SizedBox(width: 15),
            _controlButton(
              icon: _videoOff ? Icons.videocam_off : Icons.videocam,
              color: _videoOff ? Colors.red : Colors.white,
              onTap: () {
                setState(() => _videoOff = !_videoOff);
                _engine?.muteLocalVideoStream(_videoOff);
              },
            ),
            const SizedBox(width: 15),
            _controlButton(
              icon: Icons.cameraswitch,
              color: Colors.white,
              onTap: () => _engine?.switchCamera(),
            ),
            const SizedBox(width: 15),
            _controlButton(
              icon: Icons.call_end,
              color: Colors.red,
              onTap: () {
                _engine?.leaveChannel();
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
        radius: 25,
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: ColorConstant.lightGrayColor,
        automaticallyImplyLeading: false,
        title: Text('Video Call', style: TextStyle(color: ColorConstant.whiteColor)),
      ),
      body: Stack(
        children: [
          _videoView(),      // remote patient view or placeholder
          _localPreview(),   // doctor self-view
          _toolbar(),        // controls
        ],
      ),
    );
  }
}
