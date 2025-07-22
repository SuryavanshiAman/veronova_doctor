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
// //
//
//
// class VideoStream extends StatefulWidget {
//   final String channelName;
//   const VideoStream({Key? key,required this.channelName}) : super(key: key);
//
//   @override
//   State<VideoStream> createState() => _VideoStreamState();
// }
//
// class _VideoStreamState extends State<VideoStream> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   bool _muted = false;
//   bool _videoOff = false;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     final data = Provider.of<TokenViewModel>(context, listen: false).modelData;
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//
//     //create the engine
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
//       token: data?.token??"",
//       channelId: widget.channelName,
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
//                 setState(() {
//                   _muted = !_muted;
//                   _engine.muteLocalAudioStream(_muted);
//                   print(_engine.muteLocalAudioStream(_muted));
//                   print("aman");
//                 } );
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
//               icon: Icons.cameraswitch,
//               color: Colors.white,
//               onTap: () => _engine.switchCamera(),
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
//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
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
//           _toolbar()
//         ],
//       ),
//     );
//   }
//
//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection:  RtcConnection(channelId: widget.channelName),
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


import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

void main() {
  runApp(MaterialApp(
    home: SlotSelectionScreen(),
  ));
}

class SlotSelectionScreen extends StatefulWidget {
  @override
  _SlotSelectionScreenState createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends State<SlotSelectionScreen> {
  final List<Map<String, dynamic>> daysList = [
    {"id": 1, "date": "21-07-2025", "day": "Monday"},
    {"id": 3, "date": "23-07-2025", "day": "Wednesday"},
    {"id": 4, "date": "24-07-2025", "day": "Thursday"},
    {"id": 5, "date": "25-07-2025", "day": "Friday"},
    {"id": 6, "date": "26-07-2025", "day": "Saturday"},
  ];

  final Map<String, List<String>> slotsByMeal = {
    'Morning': ['09:00 AM', '09:30 AM', '10:00 AM'],
    'Afternoon': ['01:00 PM', '01:30 PM', '02:00 PM'],
    'Evening': ['07:00 PM', '07:30 PM', '08:00 PM'],
  };

  int selectedDayId = 1;
  String selectedTime = '';
  String selectedMeal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFCF9),
      appBar: AppBar(
        backgroundColor: ColorConstant.lightGrayColor,
        elevation: 1,
        title: const Text('Create Slot', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(width: 4, height: 20, color: ColorConstant.lightGrayColor),
                const SizedBox(width: 8),
                const Text(
                  'Select day and time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Date', style: TextStyle(fontSize: 16)),
          ),

          // Date Scroll
          Container(
            height: 75,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysList.length,
              itemBuilder: (context, index) {
                final day = daysList[index];
                final isSelected = selectedDayId == day['id'];
                final dateParts = day['date'].split('-');
                final formattedDate = "${dateParts[0]}-${DateFormat('MMM').format(DateFormat('MM').parse(dateParts[1]))}";

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayId = day['id'];
                      selectedTime = '';
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? ColorConstant.lightGrayColor : const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day['day'].substring(0, 3),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // Time Slot Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: slotsByMeal.entries.map((entry) {
                final meal = entry.key;
                final slots = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meal, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Container(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: slots.length,
                        itemBuilder: (context, index) {
                          final time = slots[index];
                          final isSelected = selectedTime == time;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTime = time;
                                selectedMeal = meal;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? ColorConstant.lightGrayColor : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                time,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          ),

        ],
      ),
      bottomSheet: generateSlotButton(),
    );
  }

  Widget generateSlotButton() {
    // final slotProvider = Provider.of<SlotViewModel>(context);
    return ButtonConst(
      // onTap: () async {
      //   UserViewModel userViewModel = UserViewModel();
      //   String? userId = await userViewModel.getUser();
      //   setState(() {
      //     slotProvider.selectedSlotsData = [];
      //     if (kDebugMode) {
      //       print(
      //           "selected slot detail: ${jsonEncode(slotProvider.selectedSlotsData)}");
      //     }
      //     log("=======${slotProvider.selectedSlotsData}");
      //     final completeSlotDataFormat = {
      //       "doctor_id": userId,
      //       "week_day": slotProvider.weekend[currentIndex].toString().toLowerCase(),
      //     };
      //     if (slotProvider.weekend[currentIndex].isEmpty) {
      //       Utils.show("Please Select Slot", context);
      //     } else {
      //       slotProvider.slotApi(context, completeSlotDataFormat);
      //     }
      //     log("=======${completeSlotDataFormat}");
      //   });
      // },
      onTap: () async {

      },

      color: ColorConstant.primaryColor,
      alignment: Alignment.center,
      label: "Generate Slots",
      fontSize: 18,
      width: width,
      height: height * 0.060,
      fontWeight: FontWeight.w600,
    );
  }
}
