
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../../main.dart';
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
//   late RtcEngine _engine;
//   int _localUid = Random().nextInt(1000000);
//   final List<int> _remoteUids = [];
//   bool _muted = false;
//   bool _videoOff = false;
//   bool _engineInitialized = false;
//
//   // final String appId = "fd627d26d7264a1ba0b12b6125e3250f"; // Replace with your App ID
//   // final String token = "006fd627d26d7264a1ba0b12b6125e3250fIAAEeJiP+1otxK5qf/PpyVkrud/g8okBV6SgwwA2tHg4pxTc6YMh39v0IgA6ZthLmGx8aAQAAQAoKXtoAgAoKXtoAwAoKXtoBAAoKXto"; // Replace with your generated token
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(
//       RtcEngineContext(
//         appId: "fd627d26d7264a1ba0b12b6125e3250f",
//         channelProfile: ChannelProfileType.channelProfileCommunication,
//       ),
//     );
//
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
//           print("✅ Joined channel with UID: ${connection.localUid}");
//           setState(() => _engineInitialized = true);
//
//           // ✅ Manually publish tracks after successful join
//           await _engine.muteLocalAudioStream(false);
//           await _engine.muteLocalVideoStream(false);
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           print("👤 Remote user joined: $remoteUid");
//           if (!_remoteUids.contains(remoteUid)) {
//             setState(() => _remoteUids.add(remoteUid));
//           }
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           print("🚫 Remote user left: $remoteUid");
//           setState(() => _remoteUids.remove(remoteUid));
//         },
//       ),
//     );
//
//     await _engine.enableVideo();
//     await _engine.enableAudio();
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.startPreview();
//
//     await _engine.joinChannel(
//       token: "006fd627d26d7264a1ba0b12b6125e3250fIACcgJei9sl7nu8wn1IwJM6LhZnaSkSrIV5GhaVjQTTn3TBvvoQh39v0IgA6ZthL7Yh8aAQAAQB9RXtoAgB9RXtoAwB9RXtoBAB9RXto",
//       channelId: "L09NKM",
//       uid: _localUid,
//       options: const ChannelMediaOptions(
//         publishCameraTrack: false, // ❗ Important
//         publishMicrophoneTrack: false,
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//         channelProfile: ChannelProfileType.channelProfileCommunication,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _engine.leaveChannel();
//     _engine.release();
//     super.dispose();
//   }
//
//   Widget _renderVideo(int uid, {bool isLocal = false}) {
//     return AgoraVideoView(
//       controller: isLocal
//           ? VideoViewController(
//         rtcEngine: _engine,
//         canvas: VideoCanvas(uid: uid),
//       )
//           : VideoViewController.remote(
//         rtcEngine: _engine,
//         canvas: VideoCanvas(uid: uid),
//         connection: RtcConnection(channelId: "L09NKM"),
//       ),
//     );
//   }
//
//   Widget _videoLayout() {
//     final allUids = [_localUid, ..._remoteUids];
//
//     return GridView.builder(
//       itemCount: allUids.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: allUids.length <= 2 ? 1 : 2,
//         mainAxisSpacing: 1,
//         crossAxisSpacing: 1,
//       ),
//       itemBuilder: (_, index) {
//         final uid = allUids[index];
//         return _renderVideo(uid, isLocal: uid == _localUid);
//       },
//     );
//   }
//
//   Widget _toolbar() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 30),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.black54,
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
//             const SizedBox(width: 12),
//             _controlButton(
//               icon: _videoOff ? Icons.videocam_off : Icons.videocam,
//               color: _videoOff ? Colors.red : Colors.white,
//               onTap: () {
//                 setState(() => _videoOff = !_videoOff);
//                 _engine.muteLocalVideoStream(_videoOff);
//               },
//             ),
//             const SizedBox(width: 12),
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
//         radius: 24,
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
//         backgroundColor: Colors.black,
//         title: const Text("Video Call", style: TextStyle(color: Colors.white)),
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(child: _videoLayout()),
//           _toolbar(),
//         ],
//       ),
//     );
//   }
// }
/// omar code
// class VideoScreen extends StatefulWidget {
//   final String channelName;
//   // final Result? agoraData;
//   // final String? tokenFromMain;
//   // final String? channelFromMain;
//   // final String? callerIdFromMain;
//   const VideoScreen({super.key, required this.channelName});
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     // token = widget.agoraData.token.toString();
//     token = "006fd627d26d7264a1ba0b12b6125e3250fIACcgJei9sl7nu8wn1IwJM6LhZnaSkSrIV5GhaVjQTTn3TBvvoQh39v0IgA6ZthL7Yh8aAQAAQB9RXtoAgB9RXtoAwB9RXtoBAB9RXto";
//     if (kDebugMode) {
//       print(token);
//       print("token chala");
//     }
//     // channel = "sweetmeet-1";
//     // channel = widget.agoraData!.channel.toString();
//     channel = "L09NKM";
//     if (kDebugMode) {
//       print(channel);
//       print("channel");
//     }
//     initAgora();
//   }
//
//
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   bool _isMuted = false;
//   bool _isFrontCamera = true;
//   late RtcEngine _engine;
//
//   // // final String appId = "c03a3f9678414dceb45332ac293e2ec4";
//   // final String appId = "542a2c04941043518735d60760a2b5b5";
//   late String token;
//   late String channel;
//
//   // final CallStatusViewModel _callStatusViewModel = CallStatusViewModel();
//
//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: "fd627d26d7264a1ba0b12b6125e3250f",
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//
//     await _engine.enableAudio();
//     await _engine.muteLocalAudioStream(false);
//
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
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
//           // _callStatusViewModel.callStatusApi(context, widget.agoraData.id);
//           // print("widget.agoraData.id: ${widget.agoraData.id}");
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//           // _onCallEnd();
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//         onError: (errorCode, String string) {
//           debugPrint('Agora error: $errorCode');
//         },
//       ),
//     );
//
//     await _engine.enableVideo();
//     await _engine.startPreview();
//
//     await _engine.joinChannel(
//       token: token,
//       channelId: channel,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _dispose();
//   }
//
//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }
//
//   void _onToggleCamera() async {
//     await _engine.switchCamera();
//     setState(() {
//       _isFrontCamera = !_isFrontCamera;
//     });
//   }
//
//   void _onToggleMute() {
//     setState(() {
//       _isMuted = !_isMuted;
//     });
//     _engine.muteLocalAudioStream(_isMuted);
//   }
//
//   // void _onCallEnd() {
//   //   _dispose();
//   //   _callStatusViewModel.callEndStatusApi(context,widget.callerIdFromMain.toString());
//   //   if (kDebugMode) {
//   //     print("callend:${widget.callerIdFromMain.toString()}");
//   //   }
//   //   Navigator.pop(context);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         // decoration:  const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesVideoBg),fit: BoxFit.fill)),
//         child: Stack(
//           children: [
//             Center(
//               child: _remoteVideo(),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: SizedBox(
//                 width: 105,
//                 height: 154,
//                 child: Center(
//                   child: _localUserJoined
//                       ? AgoraVideoView(
//                     controller: VideoViewController(
//                       rtcEngine: _engine,
//                       canvas: const VideoCanvas(uid: 0),
//                     ),
//                   )
//                       : const CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//             if (_localUserJoined && _remoteUid != null) _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _toolbar() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 48),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             IconButton(
//               onPressed: _onToggleMute,
//               icon: Icon(
//                 _isMuted ? Icons.mic_off : Icons.mic,
//                 color: _isMuted ? Colors.red : Colors.white,
//               ),
//               iconSize: 32.0,
//             ),
//             // IconButton(
//             //   onPressed: _onCallEnd,
//             //   icon: const Icon(Icons.call_end),
//             //   color: Colors.red,
//             //   iconSize: 32.0,
//             // ),
//             IconButton(
//               onPressed: _onToggleCamera,
//               icon: Icon(
//                 _isFrontCamera ? Icons.camera_front : Icons.camera_rear,
//                 color: Colors.white,
//               ),
//               iconSize: 32.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//           'Please wait for remote user to join',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white)
//       );
//     }
//   }
// }

class VideoScreen extends StatefulWidget {
  final String channelName;
  // final String? tokenFromMain;
  // final String? channelFromMain;
  // final String? callerIdFromMain;

  const VideoScreen({
    super.key,

    // this.tokenFromMain,
    // this.channelFromMain,
    required this.channelName,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late RtcEngine _engine;
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _isMuted = false;
  bool _isFrontCamera = true;
  // late String token;
  // late String channel;
  bool _hasShownJoinPopup = false;

  // final String appId = "542a2c04941043518735d60760a2b5b5";
  // final CallStatusViewModel _callStatusViewModel = CallStatusViewModel();

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_engineInitialized) {
      initAgora(); // ✅ Safe here
      _engineInitialized = true;
    }
  }

  bool _engineInitialized = false;
  Future<void> initAgora() async {
    final data=Provider.of<TokenViewModel>(context,listen: false).modelData;
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: "fd627d26d7264a1ba0b12b6125e3250f",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    _engine.muteLocalAudioStream(!_isMuted);
    _engine.muteLocalVideoStream(!_isMuted);
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });

          if (!_hasShownJoinPopup) {
            _hasShownJoinPopup = true;
            Future.delayed(Duration.zero, () => _showUserJoinedDialog());
          }
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
          _onCallEnd();
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onError: (errorCode, String message) {
          debugPrint('Agora error: $errorCode, $message');
        },
      ),
    );

    await _engine.joinChannel(
      // token: data?.token??"",
      token:"006fd627d26d7264a1ba0b12b6125e3250fIAAtm6f/Ti2Ljj+H/8BwTo6FaDvLzk1E+e6CSDGS8zAtCMgOgNkh39v0IgASnKkPtVN/aAQAAQBFEH5oAgBFEH5oAwBFEH5oBABFEH5o",
      // channelId: widget.channelName,
      channelId:"D215CJ",
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _onToggleCamera() async {
    await _engine.switchCamera();
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
  }

  void _onToggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _engine.muteLocalAudioStream(_isMuted);
    _engine.muteLocalVideoStream(_isMuted);

  }

  void _onCallEnd() {
    _dispose();
    // // _callStatusViewModel.callEndStatusApi(context, widget.callerIdFromMain.toString());
    // if (kDebugMode) {
    //   print("Call Ended: ${widget.callerIdFromMain}");
    // }
    Navigator.pop(context);
  }

  // void _showUserJoinedDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => AlertDialog(
  //       title: const Text("User Joined"),
  //       content: const Text("User has joined this meeting successfully."),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text("OK"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  void _showUserJoinedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "🎉",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 12),
              const Text(
                "User Joined!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "The participant has joined this meeting successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: (){
                  _engine.muteLocalAudioStream(_isMuted);
                  _engine.muteLocalVideoStream(_isMuted);
                  Navigator.of(context).pop();},
                child: const Text(
                  "Okay",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: _onToggleMute,
              icon: Icon(
                _isMuted ? Icons.mic_off : Icons.mic,
                color: _isMuted ? Colors.red : Colors.white,
              ),
              iconSize: 32.0,
            ),
            IconButton(
              onPressed: _onCallEnd,
              icon: const Icon(Icons.call_end),
              color: Colors.red,
              iconSize: 32.0,
            ),
            IconButton(
              onPressed: _onToggleCamera,
              icon: Icon(
                _isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                color: Colors.white,
              ),
              iconSize: 32.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: "D215CJ"),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage(Assets.imagesVideoBg),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: Stack(
          children: [
            Center(child: _remoteVideo()),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 105,
                height: 154,
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
            // if (_localUserJoined && _remoteUid != null)
              _toolbar(),
          ],
        ),
      ),
    );
  }
}



