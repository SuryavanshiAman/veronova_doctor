import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doctor_apk/view_model/token_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class AgoraAgoraVideoScreen extends StatefulWidget {
  final String channelName;
  const AgoraAgoraVideoScreen({super.key, required this.channelName});

  @override
  State<AgoraAgoraVideoScreen> createState() => _AgoraAgoraVideoScreenState();
}

class _AgoraAgoraVideoScreenState extends State<AgoraAgoraVideoScreen> {


  @override
  void initState() {
    super.initState();
    // token = widget.agoraData.token.toString();
    // token = widget.tokenFromMain.toString();
    // if (kDebugMode) {
    //   print(token);
    //   print("token chala");
    // }
    // // channel = "sweetmeet-1";
    // // channel = widget.agoraData!.channel.toString();
    // channel = widget.channelFromMain.toString();
    // if (kDebugMode) {
    //   print(channel);
    //   print("channel");
    // }
    initAgora();
  }


  int? _remoteUid;
  bool _localUserJoined = false;
  bool _isMuted = false;
  bool _isFrontCamera = true;
  late RtcEngine _engine;

  // final String appId = "c03a3f9678414dceb45332ac293e2ec4";
  final String appId = "fd627d26d7264a1ba0b12b6125e3250f";
  // late String token;
  // late String channel;

  // final CallStatusViewModel _callStatusViewModel = CallStatusViewModel();

  Future<void> initAgora() async {
    final data = Provider.of<TokenViewModel>(context, listen: false).modelData;

    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await _engine.enableAudio();
    await _engine.muteLocalAudioStream(false);

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

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
          // _callStatusViewModel.callStatusApi(context, widget.agoraData.id);
          // print("widget.agoraData.id: ${widget.agoraData.id}");
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
          // _onCallEnd();
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onError: (errorCode, String string) {
          debugPrint('Agora error: $errorCode');
        },
      ),
    );

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
    // _engine.muteLocalAudioStream(_isMuted);
    _engine.muteLocalVideoStream(_isMuted);
  }

  // void _onCallEnd() {
  //   _dispose();
  //   _callStatusViewModel.callEndStatusApi(context,widget.callerIdFromMain.toString());
  //   if (kDebugMode) {
  //     print("callend:${widget.callerIdFromMain.toString()}");
  //   }
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        // decoration:  const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesVideoBg),fit: BoxFit.fill)),
        child: Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
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
              onPressed: (){},
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
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Text(
          'Please wait for remote user to join',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white)
      );
    }
  }
}