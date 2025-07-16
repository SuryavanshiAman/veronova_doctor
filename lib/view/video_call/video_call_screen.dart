//
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// import '../../res/color_constant.dart';
// import '../../view_model/token_view_model.dart';
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
//   RtcEngine? _engine;
//   int? _remoteUid;
//   bool _joined = false;
//   bool _muted = false;
//   bool _videoOff = false;
//   bool _engineInitialized = false;
//
//   int _localUid = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     final data = Provider.of<TokenViewModel>(context, listen: false).modelData;
//
//     await [Permission.microphone, Permission.camera].request();
//
//     _localUid = int.tryParse(data?.uid ?? "") ?? 0;
//
//     _engine = createAgoraRtcEngine();
//     await _engine?.initialize(
//       RtcEngineContext(appId: data?.appId ?? ""),
//     );
//
//     _engine?.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           print("Joined channel with uid: ${connection.localUid}");
//           setState(() => _joined = true);
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           print("Remote user joined: $remoteUid");
//           setState(() => _remoteUid = remoteUid);
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           print("Remote user left: $remoteUid");
//           setState(() => _remoteUid = null);
//         },
//       ),
//     );
//
//     await _engine?.enableVideo();
//     await _engine?.startPreview();
//
//     await _engine?.joinChannel(
//       token: data?.token ?? "",
//       channelId: widget.channelName,
//       uid: _localUid,
//       options: const ChannelMediaOptions(),
//     );
//
//     setState(() => _engineInitialized = true);
//   }
//
//   @override
//   void dispose() {
//     _engine?.leaveChannel();
//     _engine?.release();
//     super.dispose();
//   }
//
//   Widget _videoView() {
//     if (!_engineInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine!,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channelName),
//         ),
//       );
//     } else {
//       return const Center(
//         child: Text(
//           'Waiting for patient to join...',
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       );
//     }
//   }
//
//   Widget _localPreview() {
//     if (!_engineInitialized) return const SizedBox.shrink();
//
//     return Positioned(
//       right: 16,
//       top: 16,
//       width: 120,
//       height: 160,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: AgoraVideoView(
//           controller: VideoViewController(
//             rtcEngine: _engine!,
//             canvas: VideoCanvas(uid: _localUid), // ✅ Use correct UID
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _toolbar() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         margin: const EdgeInsets.only(bottom: 30),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.3),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _controlButton(
//               icon: _muted ? Icons.mic_off : Icons.mic,
//               color: _muted ? Colors.red : Colors.white,
//               onTap: () {
//                 setState(() => _muted = !_muted);
//                 _engine?.muteLocalAudioStream(_muted);
//               },
//             ),
//             const SizedBox(width: 15),
//             _controlButton(
//               icon: _videoOff ? Icons.videocam_off : Icons.videocam,
//               color: _videoOff ? Colors.red : Colors.white,
//               onTap: () {
//                 setState(() => _videoOff = !_videoOff);
//                 _engine?.muteLocalVideoStream(_videoOff);
//               },
//             ),
//             const SizedBox(width: 15),
//             _controlButton(
//               icon: Icons.cameraswitch,
//               color: Colors.white,
//               onTap: () => _engine?.switchCamera(),
//             ),
//             const SizedBox(width: 15),
//             _controlButton(
//               icon: Icons.call_end,
//               color: Colors.red,
//               onTap: () {
//                 _engine?.leaveChannel();
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _controlButton({
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CircleAvatar(
//         radius: 25,
//         backgroundColor: color.withOpacity(0.2),
//         child: Icon(icon, color: color, size: 28),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: ColorConstant.lightGrayColor,
//         automaticallyImplyLeading: false,
//         title: Text('Video Call', style: TextStyle(color: ColorConstant.whiteColor)),
//       ),
//       body: Stack(
//         children: [
//           _videoView(),
//           _localPreview(),
//           _toolbar(),
//         ],
//       ),
//     );
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../res/color_constant.dart';
import '../../view_model/token_view_model.dart';

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
  bool _muted = true;
  bool _videoOff = true;
  bool _engineInitialized = false;

  int _localUid = 0;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    final data = Provider.of<TokenViewModel>(context, listen: false).modelData;

    await [Permission.microphone, Permission.camera].request();

    // Safely get UID or fallback
    if (data?.uid == null || data!.uid!.isEmpty) {
      print("⚠️ UID is empty from backend. Generating random UID");
      _localUid = Random().nextInt(1000000);
    } else {
      _localUid = int.tryParse(data.uid!) ?? Random().nextInt(1000000);
    }

    _engine = createAgoraRtcEngine();

    await _engine!.initialize(
      RtcEngineContext(appId: data?.appId ?? ""),
    );

    // Register all events
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("✅ Joined channel with UID: ${connection.localUid}");
          setState(() => _joined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("👤 Remote user joined: $remoteUid");
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          print("🚫 Remote user left: $remoteUid");
          setState(() => _remoteUid = null);
        },
        onError: (ErrorCodeType code, String message) {
          print("❌ Agora error [$code]: $message");
        },
      ),
    );

    // Enable audio/video and set role
    await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine!.enableVideo();
    await _engine!.enableAudio();
    await _engine!.startPreview();

    // Join the channel
    await _engine!.joinChannel(
      token: data?.token ?? "",
      channelId: widget.channelName,
      uid: _localUid,
      options: const ChannelMediaOptions(
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
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
          'Waiting for participant to join...',
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
            canvas: VideoCanvas(uid: _localUid),
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
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
          _videoView(),
          _localPreview(),
          _toolbar(),
        ],
      ),
    );
  }
}
