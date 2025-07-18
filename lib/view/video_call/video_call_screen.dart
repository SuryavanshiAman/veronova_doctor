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
import '../../view_model/token_view_model.dart';

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
//  late RtcEngine _engine;
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
//     // Safely get UID or fallback
//     if (data?.uid == null || data!.uid!.isEmpty) {
//       print("⚠️ UID is empty from backend. Generating random UID");
//       _localUid = Random().nextInt(1000000);
//       // _localUid = 0;
//     } else {
//       _localUid = int.tryParse(data.uid!) ?? Random().nextInt(1000000);
//     }
//
//     _engine = createAgoraRtcEngine();
//
//     await _engine.initialize(
//       RtcEngineContext(appId:"fd627d26d7264a1ba0b12b6125e3250f"),
//       // RtcEngineContext(appId: "d0a32a9a76bd4e8a9e0a51612f4aa6da"),
//     );
//
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           print("✅ Joined channel with UID: ${connection.localUid}");
//           setState(() => _joined = true);
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           print("👤 Remote user joined: $remoteUid");
//           setState(() => _remoteUid = remoteUid);
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           print("🚫 Remote user left: $remoteUid");
//           setState(() => _remoteUid = null);
//         },
//         onError: (ErrorCodeType code, String message) {
//           print("❌ Agora error [$code]: $message");
//         },
//       ),
//     );
//
//     // Enable audio/video and set role
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();
//     await _engine.enableAudio();
//
//
//     // Join the channel
//     await _engine.joinChannel(
//       token: data?.token ?? "",
//       // token:"007eJxTYHiu3FeiamCd4nJf+FVYuubcH//bj3MGyrPcuBuSVMpq90SBIcUg0dgo0TLR3CwpxSTVItEy1SDR1NDM0CjNJDHRLCXRuaoioyGQkSHg/nZGRgYIBPGFGcpSi/Lz8ssS41Pyk0vyi+ITC7IZGAALgiUg",
//       channelId: widget.channelName,
//       // uid: _localUid,
//       uid: 0,
//       options: const ChannelMediaOptions(
//         publishCameraTrack: true,
//         publishMicrophoneTrack: true,
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//     );
//
//     setState(() => _engineInitialized = true);
//   }
//
//   @override
//   void dispose() {
//     _engine.leaveChannel();
//     _engine.release();
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
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channelName),
//         ),
//       );
//     } else {
//       return const Center(
//         child: Text(
//           'Waiting for participant to join...',
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
//             rtcEngine: _engine,
//             canvas: VideoCanvas(uid: _localUid),
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
//                 _engine.muteLocalAudioStream(_muted);
//               },
//             ),
//             const SizedBox(width: 15),
//             _controlButton(
//               icon: _videoOff ? Icons.videocam_off : Icons.videocam,
//               color: _videoOff ? Colors.red : Colors.white,
//               onTap: () {
//                 setState(() => _videoOff = !_videoOff);
//                 _engine.muteLocalVideoStream(_videoOff);
//               },
//             ),
//             const SizedBox(width: 15),
//             _controlButton(
//               icon: Icons.cameraswitch,
//               color: Colors.white,
//               onTap: () => _engine.switchCamera(),
//             ),
//             const SizedBox(width: 15),
//             _controlButton(
//               icon: Icons.call_end,
//               color: Colors.red,
//               onTap: () {
//                 _engine.leaveChannel();
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
class VideoCallPage extends StatefulWidget {
  final String channelName;

  const VideoCallPage({Key? key, required this.channelName}) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late RtcEngine _engine;
  int? _remoteUid;
  bool _joined = false;
  bool _muted = false;
  bool _videoOff = false;
  bool _engineInitialized = false;

  int _localUid = 0;
  List<int> _remoteUids = [];
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // final data = Provider.of<TokenViewModel>(context, listen: false).modelData;

    await [Permission.microphone, Permission.camera].request();

    _localUid = int.tryParse("0") ?? Random().nextInt(1000000);

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: "fd627d26d7264a1ba0b12b6125e3250f",
        channelProfile: ChannelProfileType.channelProfileCommunication,

      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("✅ Joined channel with UID: ${connection.localUid}");
          setState(() => _joined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("👤 Remote user joined: $remoteUid");
          setState(() =>  _remoteUids.add(remoteUid));
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          print("🚫 Remote user left: $remoteUid");
          setState(() => _remoteUid = null);
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.enableAudio();
    Future.delayed(Duration(seconds: 15),(){
      print("valueeeeeee");
      _engine.muteLocalAudioStream(false);
      print(_engine.muteLocalAudioStream(false));
      print("valueeeeeee2222");
    });

    // Delay to allow engine setup
    await Future.delayed(const Duration(milliseconds: 500));

    await _engine.joinChannel(
      // token: '006fd627d26d7264a1ba0b12b6125e3250fIABqcV6LQlcW47At4lrqkSPUFBCUepFRrYdCxg1L5b2SYYQZsu0AAAAAIgBP3rrskiN7aAQAAQAi4HloAgAi4HloAwAi4HloBAAi4Hlo',
      token:"006fd627d26d7264a1ba0b12b6125e3250fIAAJ9ZPUDKxNrfzqh2qzl9MtZ4amc0Q83CbSueNU/iQ1joQZsu0AAAAAIgA2aBkMdIJ7aAQAAQAEP3poAgAEP3poAwAEP3poBAAEP3po",
      channelId: "meet123",
      uid: _localUid,
      options: const ChannelMediaOptions(
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    await _engine.startPreview();

    setState(() => _engineInitialized = true);
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId:"meet123"),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Waiting for participant to join...',
          style: TextStyle(color: Colors.white),
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
            rtcEngine: _engine,
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
                setState(() => _muted = !_muted);
                _engine.muteLocalAudioStream(_muted);
                print(_engine.muteLocalAudioStream(_muted));
                print(_engine.muteLocalAudioStream(_muted));
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

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TokenViewModel>(context, ).modelData;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Video Call",style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
        children: [
          _remoteVideo(),
          _localPreview(),
          _toolbar(),
        ],
      ),
    );
  }
}


// import 'dart:async';
//
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:doctor_apk/view_model/token_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
//
// // const appId = "<-- Insert App Id -->";
// // const token = "<-- Insert Token -->";
// // const channel = "<-- Insert Channel Name -->";
//
//
// class VideoCallPage extends StatefulWidget {
//   const VideoCallPage({Key? key}) : super(key: key);
//
//   @override
//   State<VideoCallPage> createState() => _VideoCallPageState();
// }
//
// class _VideoCallPageState extends State<VideoCallPage> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//
//     //create the engine
//     final data = Provider.of<TokenViewModel>(context, listen: false).modelData;
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: "fd627d26d7264a1ba0b12b6125e3250f",
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );
//
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();
//
//     await _engine.joinChannel(
//       token: data!.token.toString(),
//       channelId: data.channelName.toString(),
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     _dispose();
//   }
//
//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }
//
//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<TokenViewModel>(context, listen: false).modelData;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(data!.channelName.toString()),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SizedBox(
//               width: 100,
//               height: 150,
//               child: Center(
//                 child: _localUserJoined
//                     ? AgoraVideoView(
//                   controller: VideoViewController(
//                     rtcEngine: _engine,
//                     canvas: const VideoCanvas(uid: 0),
//                   ),
//                 )
//                     : const CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Display remote user's video
//   Widget _remoteVideo(channelName) {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection:  RtcConnection(channelId: channelName),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }