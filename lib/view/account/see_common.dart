// // import 'package:doctor_apk/generated/assets.dart';
// // import 'package:doctor_apk/media_querry.dart';
// // import 'package:doctor_apk/res/button_context.dart';
// // import 'package:doctor_apk/res/text_context.dart';
// //
// // import 'package:doctor_apk/res/color_constant.dart';
// // import 'package:doctor_apk/view/account/common_day.dart';
// // import 'package:doctor_apk/view/account/create_Individual.dart';
// // import 'package:doctor_apk/view_model/slot_view_model.dart';
// //
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../../main.dart';
// //
// // class SeeCommon extends StatefulWidget {
// //   const SeeCommon({super.key});
// //
// //   @override
// //   State<SeeCommon> createState() => _SeeCommonState();
// // }
// //
// // class _SeeCommonState extends State<SeeCommon> {
// //   int clickDate = -1;
// //   String? data;
// //   String? slots;
// //   bool showVal = false;
// //   List<DateTime> next15Days(DateTime startDate) {
// //     List<DateTime> dates = [];
// //     for (int i = 0; i <= 7; i++) {
// //       dates.add(startDate.add(Duration(days: i)));
// //     }
// //     return dates;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     List<dynamic> morningList = [
// //       '11:00 AM',
// //       '11:20 AM',
// //       '11:40 AM',
// //       '12:00 PM',
// //       '12:20 PM'
// //     ];
// //     List<dynamic> morningList1 = [
// //       '02:00 PM',
// //       '02:20 PM',
// //       '02:40 PM',
// //     ];
// //     DateTime currentDate = DateTime.now();
// //     List<DateTime> nextDays = next15Days(currentDate);
// //     final slotViewModel = Provider.of<SlotViewModel>(context);
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: GestureDetector(
// //             onTap: () {
// //               Navigator.pop(context);
// //             },
// //             child: Image.asset(
// //               "assets/icon/arrow_1.png",
// //               scale: 6,
// //               color: Color(0xff1E1E1E),
// //             )),
// //         centerTitle: true,
// //         title: TextContext(
// //           data: "See Common Day Schedule",
// //           fontSize: 17,
// //           fontWeight: FontWeight.w600,
// //           color: Color(0xff1E1E1E),
// //         ),
// //         backgroundColor: ColorConstant.containerFillColor,
// //       ),
// //       backgroundColor: ColorConstant.scaffoldBgColor,
// //       body: Column(
// //         children: [
// //           SizedBox(
// //             height: height * 0.010,
// //           ),
// //           Container(
// //             width: width,
// //             color: ColorConstant.whiteColor,
// //             child: Column(
// //               children: [
// //                 SizedBox(
// //                   height: height * 0.010,
// //                 ),
// //                 Padding(
// //                   padding: EdgeInsets.fromLTRB(width * 0.010, 5, 0, 0),
// //                 ),
// //                 Container(
// //                   width: width,
// //                   margin:
// //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         width: width * 0.050,
// //                         child: Image.asset(
// //                           Assets.iconHome,
// //                           color: ColorConstant.buttonBlueColor,
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         width: width * 0.03,
// //                       ),
// //                       const TextContext(
// //                         data: "Clinic Visit Slot",
// //                         fontWeight: FontWeight.w500,
// //                         color: Color(0xff000000),
// //                         fontFamily: "poppins_reg",
// //                         fontSize: 12,
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 10,
// //                 ),
// //                 SizedBox(
// //                   width: width,
// //                   height: height * 0.062,
// //                   child: ListView.builder(
// //                       itemCount: nextDays.length,
// //                       shrinkWrap: true,
// //                       scrollDirection: Axis.horizontal,
// //                       itemBuilder: (context, index) {
// //                         return Padding(
// //                           padding: const EdgeInsets.symmetric(horizontal: 10),
// //                           child: InkWell(
// //                             onTap: () {
// //                               setState(() {
// //                                 clickDate = index;
// //                                 currentIndex = index;
// //                                 data = nextDays[index].toString();
// //                               });
// //                             },
// //                             child: Container(
// //                               alignment: Alignment.center,
// //                               width: width * 0.35,
// //                               decoration: BoxDecoration(
// //                                   color: currentIndex == index
// //                                       ? ColorConstant.lightGrayColor
// //                                       : ColorConstant.whiteColor,
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   border: clickDate == index
// //                                       ? Border.all(
// //                                           width: 1,
// //                                           color: ColorConstant.rBorderSideColor)
// //                                       : Border.all(
// //                                           width: 1, color: Color(0xff979797))),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   TextContext(
// //                                       data: DateFormat.EEEE()
// //                                           .format(nextDays[index]),
// //                                       fontSize: 14,
// //                                       fontWeight: FontWeight.w500,
// //                                       fontFamily: "poppins_reg",
// //                                       color: const Color(0xff1E1E1E)),
// //                                   TextContext(
// //                                       data: "10 Slots",
// //                                       fontSize: 12,
// //                                       fontWeight: FontWeight.w400,
// //                                       color: Color(0xff229505)),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         );
// //                       }),
// //                 ),
// //                 SizedBox(
// //                   height: 30,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 15),
// //             // height: height/1.8,
// //             width: width,
// //             color: ColorConstant.whiteColor,
// //             child: Column(
// //               children: [
// //                 SizedBox(
// //                   height: height * 0.010,
// //                 ),
// //                 TextContext(
// //                   data: data.toString() == "null"
// //                       ? ""
// //                       : DateFormat("EEEE")
// //                           .format(DateTime.parse(data.toString())),
// //                   fontSize: 15,
// //                   fontWeight: FontWeight.w500,
// //                   color: const Color(0xff1E1E1E),
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 slotViewModel.slotHistoryModel == null
// //                     ? Padding(
// //                         padding: const EdgeInsets.symmetric(
// //                             vertical: 15, horizontal: 15),
// //                         child: ButtonConst(
// //                           onTap: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => const CommonDay()),
// //                             );
// //                           },
// //                           height: height * 0.06,
// //                           alignment: Alignment.center,
// //                           borderRadius: BorderRadius.circular(5),
// //                           padding: EdgeInsets.symmetric(
// //                             vertical: 10,
// //                           ),
// //                           color: ColorConstant.primaryColor,
// //                           label: "Create Your First schedule now!",
// //                           fontSize: 16,
// //                         ),
// //                       )
// //                     : slotList(context),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget slotList(BuildContext context) {
// //     final slotViewModel = Provider.of<SlotViewModel>(context);
// //     final width = MediaQuery.of(context).size.width;
// //     return Container(
// //       padding: const EdgeInsets.symmetric(vertical: 15),
// //       color: ColorConstant.whiteColor,
// //       child: ListView.builder(
// //         shrinkWrap: true,
// //         physics: const NeverScrollableScrollPhysics(),
// //         itemCount:
// //             slotViewModel.slotHistoryModel!.slotHistoryData!.slotdata!.length,
// //         itemBuilder: (context, index) {
// //           final slotData =
// //               slotViewModel.slotHistoryModel!.slotHistoryData!.slotdata![index];
// //           final List<String> slots = generateSlots(
// //               slotData.sTime!, slotData.eTime!, slotData.sDuration!);
// //           return Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: List.generate(
// //                         int.parse((width / 5).toStringAsFixed(0)), (index) {
// //                       return Container(
// //                         height: 0.6,
// //                         width: 2,
// //                         color: ColorConstant.greyColor,
// //                       );
// //                     })),
// //                 AppConstant.spaceHeight25,
// //                 slotRow(
// //                   iconPath: getIconPath(slotData.slotType!),
// //                   title: getSlotTitle(slotData.slotType!),
// //                   slotCount: slots.length,
// //                   width: width,
// //                   id: slotData.id.toString(),
// //                   slotType: slotData.slotType.toString(),
// //                 ),
// //                 AppConstant.spaceHeight20,
// //                 GridView.builder(
// //                   shrinkWrap: true,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 4,
// //                     mainAxisSpacing: 10,
// //                     crossAxisSpacing: 10,
// //                     childAspectRatio: 2,
// //                   ),
// //                   itemCount: slots.length,
// //                   itemBuilder: (context, slotIndex) {
// //                     return Container(
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                             width: 1, color: ColorConstant.primaryColor),
// //                       ),
// //                       alignment: Alignment.center,
// //                       child: TextContext(
// //                         data: "${slots[slotIndex]} Am",
// //                         color: ColorConstant.primaryColor,
// //                         fontWeight: FontWeight.w500,
// //                         fontFamily: "poppins_reg",
// //                         fontSize: 12,
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// // // Function to generate slots
// //   List<String> generateSlots(String sTime, String eTime, String sDuration) {
// //     print("kdf mke kme rf");
// //     print(sTime);
// //     print(eTime);
// //     final DateFormat timeFormat = DateFormat("hh:mm");
// //     final DateTime startTime = timeFormat.parse(sTime);
// //     DateTime endTime = timeFormat.parse(eTime);
// //
// //     // Handle PM/AM boundaries
// //     if (endTime.isBefore(startTime)) {
// //       endTime = endTime.add(const Duration(hours: 12));
// //     }
// //
// //     print("dsdsk $sDuration");
// //     final int slotDuration = int.parse(sDuration);
// //     final List<String> slots = [];
// //
// //     DateTime currentTime = startTime;
// //     while (currentTime.isBefore(endTime)) {
// //       slots.add(timeFormat.format(currentTime));
// //       currentTime = currentTime.add(Duration(minutes: slotDuration));
// //     }
// //
// //     return slots;
// //   }
// //
// // // Helper function to get the icon path based on slot type
// //   String getIconPath(int slotType) {
// //     switch (slotType) {
// //       case 1:
// //         return Assets.iconMorning;
// //       case 2:
// //         return Assets.iconAfternoon;
// //       case 3:
// //         return Assets.iconEvening;
// //       default:
// //         return Assets.iconNight;
// //     }
// //   }
// //
// //   String getSlotTitle(int slotType) {
// //     switch (slotType) {
// //       case 1:
// //         return "Morning";
// //       case 2:
// //         return "Afternoon";
// //       case 3:
// //         return "Evening";
// //       default:
// //         return "Night";
// //     }
// //   }
// //
// //   Widget slotRow({
// //     required String iconPath,
// //     required String title,
// //     required int slotCount,
// //     required double width,
// //     required String id,
// //     required String slotType,
// //   }) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Row(
// //           children: [
// //             SizedBox(
// //               width: width * 0.060,
// //               child: Image.asset(iconPath),
// //             ),
// //             const SizedBox(width: 10),
// //             RichText(
// //               text: TextSpan(
// //                 children: <TextSpan>[
// //                   TextSpan(
// //                     text: "$title ",
// //                     style: const TextStyle(
// //                         color: Color(0xFF000000),
// //                         fontWeight: FontWeight.w500,
// //                         fontFamily: "poppins_reg"),
// //                   ),
// //                   TextSpan(
// //                     text: "$slotCount slots",
// //                     style: const TextStyle(
// //                         color: Color(0xFF7C7979),
// //                         fontSize: 12,
// //                         fontWeight: FontWeight.w500,
// //                         fontFamily: "poppins_reg"),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //         GestureDetector(
// //           onTap: () {
// //             Provider.of<SlotViewModel>(context, listen: false)
// //                 .deleteSlotApi("1", id, context);
// //           },
// //           child: SizedBox(
// //             width: width * 0.060,
// //             child: Image.asset("assets/icon/maskGroup.png"),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// import 'package:doctor_apk/generated/assets.dart';
// import 'package:doctor_apk/main.dart';
// import 'package:doctor_apk/res/app_constant.dart';
// import 'package:doctor_apk/res/common_delete_popup.dart';
// import 'package:doctor_apk/res/text_context.dart';
// import 'package:doctor_apk/res/button_context.dart';
// import 'package:doctor_apk/res/color_constant.dart';
// import 'package:doctor_apk/view/account/common_day.dart';
// import 'package:doctor_apk/view/account/create_Individual.dart';
// import 'package:doctor_apk/view_model/slot_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class SeeCommon extends StatefulWidget {
//   const SeeCommon({
//     super.key,
//   });
//
//   @override
//   State<SeeCommon> createState() => _DoctorBookAppointmentState();
// }
//
// class _DoctorBookAppointmentState extends State<SeeCommon> {
//   List<DateTime> next15Days(DateTime startDate) {
//     List<DateTime> dates = [];
//     for (int i = 0; i <= 7; i++) {
//       dates.add(startDate.add(Duration(days: i)));
//     }
//     return dates;
//   }
//
//   List<DateTime>? nextDays;
//   int clickDate = 0;
//   String? data;
//   String? slots;
//   // bool showVal = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataAndSetDate();
//
//   }
//
//   fetchDataAndSetDate() {
//     DateTime currentDate = DateTime.now();
//     setState(() {
//       nextDays = next15Days(currentDate);
//       data = nextDays![clickDate].toString();
//     });
//     final slotViewModel = Provider.of<SlotViewModel>(context, listen: false);
//     slotViewModel.clearClickedIndex();
//     slotViewModel.getSlotDates(context);
//     slotViewModel.slotViewApi(
//         DateFormat.EEEE().format(nextDays![clickDate]).toLowerCase(),
//         DateFormat("yyyy-MM-dd").format(nextDays![clickDate]).toLowerCase(),
//         context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final slotViewModel = Provider.of<SlotViewModel>(context);
//
//     return Scaffold(
//       backgroundColor: ColorConstant.scaffoldBgColor,
//       appBar: AppBar(
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Image.asset(
//               "assets/icon/arrow_1.png",
//               scale: 6,
//               color: const Color(0xff1E1E1E),
//             )),
//         centerTitle: true,
//         title: const TextContext(
//           data: "See Common Day Schedule",
//           fontSize: 17,
//           fontWeight: FontWeight.w600,
//           color: Color(0xff1E1E1E),
//         ),
//         backgroundColor: ColorConstant.containerFillColor,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: height * 0.010,
//             ),
//             Container(
//               width: width,
//               color: ColorConstant.whiteColor,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         width: width,
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: width * 0.050,
//                               child: Image.asset(
//                                 Assets.iconHome,
//                                 color: ColorConstant.buttonBlueColor,
//                               ),
//                             ),
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             const TextContext(
//                               data: "Clinic Visit Slot",
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff000000),
//                               fontFamily: "poppins_reg",
//                               fontSize: 12,
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       SizedBox(
//                         width: width,
//                         height: height * 0.061,
//                         child: ListView.builder(
//                             itemCount: nextDays!.length,
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               final avlSlots = slotViewModel
//                                   .slotDateAvailability!.availability!
//                                   .firstWhere((e) =>
//                                       e.weekday!.toLowerCase() ==
//                                       DateFormat.EEEE()
//                                           .format(
//                                               slotViewModel.nextDays![index])
//                                           .toLowerCase())
//                                   .availableSlots;
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       clickDate = index;
//                                       currentIndex = index;
//                                       data = nextDays![index].toString();
//                                       final slotViewModel =
//                                           Provider.of<SlotViewModel>(context,
//                                               listen: false);
//                                       slotViewModel.slotViewApi(
//                                           DateFormat.EEEE()
//                                               .format(nextDays![index])
//                                               .toLowerCase(),
//                                           DateFormat("yyyy-MM-dd")
//                                               .format(nextDays![clickDate])
//                                               .toLowerCase(),
//                                           context);
//                                     });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     width: width * 0.35,
//                                     decoration: BoxDecoration(
//                                         color: clickDate == index
//                                             ? ColorConstant.lightGrayColor
//                                             : ColorConstant.whiteColor,
//                                         borderRadius: BorderRadius.circular(5),
//                                         border: clickDate == index
//                                             ? Border.all(
//                                                 width: 1,
//                                                 color: ColorConstant
//                                                     .rBorderSideColor)
//                                             : Border.all(
//                                                 width: 1,
//                                                 color:
//                                                     const Color(0xff979797))),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         TextContext(
//                                             data: DateFormat.EEEE().format(
//                                                 slotViewModel.nextDays![index]),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: "poppins_reg",
//                                             color: const Color(0xff1E1E1E)),
//                                         TextContext(
//                                             data: avlSlots! > 0
//                                                 ? "$avlSlots slots available"
//                                                 : "No slots available",
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                             color: avlSlots > 0
//                                                 ? const Color(0xff229505)
//                                                 : ColorConstant.textColor),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               // height: height/1.8,
//               width: width,
//               color: ColorConstant.whiteColor,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: height * 0.010,
//                   ),
//                   TextContext(
//                       data: data.toString() == "null"
//                           ? ""
//                           : DateFormat("EEEE")
//                               .format(DateTime.parse(data.toString())),
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xff1E1E1E)),
//                   Container(
//                     child: slotViewModel.slotHistoryModel == null
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 15),
//                             child: ButtonConst(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const CreateCommonDaySchedule()),
//                                 );
//                               },
//                               height: height * 0.06,
//                               alignment: Alignment.center,
//                               borderRadius: BorderRadius.circular(5),
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 10,
//                               ),
//                               color: ColorConstant.primaryColor,
//                               label: "Create Your First schedule now!",
//                               fontSize: 16,
//                             ),
//                           )
//                         : slotList(context),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget slotList(BuildContext context) {
//     final slotViewModel = Provider.of<SlotViewModel>(context);
//     final width = MediaQuery.of(context).size.width;
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       color: ColorConstant.whiteColor,
//       child:ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: slotViewModel
//             .slotHistoryModel!.slotHistoryData!.slotdata!.length,
//         itemBuilder: (context, index) {
//           final slotData = slotViewModel
//               .slotHistoryModel!.slotHistoryData!.slotdata![index];
//           final List<String> slots = slotViewModel.generateSlots(
//               slotData.sTime!, slotData.eTime!, slotData.sDuration!);
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(
//                         int.parse((width / 5).toStringAsFixed(0)),
//                             (index) {
//                           return Container(
//                             height: 0.6,
//                             width: 2,
//                             color: ColorConstant.greyColor,
//                           );
//                         })),
//                 AppConstant.spaceHeight25,
//                 slotRow(
//                   iconPath: getIconPath(slotData.slotType!),
//                   title: getSlotTitle(slotData.slotType!),
//                   slotCount: slots.length,
//                   width: width,
//                   id: slotData.id.toString(),
//                   slotType: slotData.slotType.toString(),
//                 ),
//                 AppConstant.spaceHeight20,
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 2,
//                   ),
//                   itemCount: slots.length,
//                   itemBuilder: (context, slotIndex) {
//                     bool isBooked = slotViewModel
//                         .slotHistoryModel!.slotHistoryData!.sdata!
//                         .where((e) => e.sTime == slots[slotIndex])
//                         .isNotEmpty;
//
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                             width: 1,
//                             color: isBooked
//                                 ? ColorConstant.greyColor
//                                 : ColorConstant.primaryColor),
//                       ),
//                       alignment: Alignment.center,
//                       child: TextContext(
//                         data: slots[slotIndex],
//                         color: isBooked
//                             ? ColorConstant.greyColor
//                             : ColorConstant.primaryColor,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: "poppins_reg",
//                         fontSize: 12,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       )
//       // ListView.builder(
//       //   shrinkWrap: true,
//       //   physics: const NeverScrollableScrollPhysics(),
//       //   itemCount:
//       //       slotViewModel.slotHistoryModel!.slotHistoryData!.slotdata!.length,
//       //   itemBuilder: (context, index) {
//       //     final slotData =
//       //         slotViewModel.slotHistoryModel!.slotHistoryData!.slotdata![index];
//       //     final List<String> slots = generateSlots(
//       //         slotData.sTime!, slotData.eTime!, slotData.sDuration!);
//       //     return Padding(
//       //       padding: const EdgeInsets.symmetric(vertical: 10),
//       //       child: Column(
//       //         crossAxisAlignment: CrossAxisAlignment.start,
//       //         children: [
//       //           Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: List.generate(
//       //                   int.parse((width / 5).toStringAsFixed(0)), (index) {
//       //                 return Container(
//       //                   height: 0.6,
//       //                   width: 2,
//       //                   color: ColorConstant.greyColor,
//       //                 );
//       //               })),
//       //           AppConstant.spaceHeight25,
//       //           slotRow(
//       //             iconPath: getIconPath(slotData.slotType!),
//       //             title: getSlotTitle(slotData.slotType!),
//       //             slotCount: slots.length,
//       //             width: width,
//       //             id: slotData.id.toString(),
//       //             slotType: slotData.slotType.toString(),
//       //           ),
//       //           AppConstant.spaceHeight20,
//       //           GridView.builder(
//       //             shrinkWrap: true,
//       //             physics: const NeverScrollableScrollPhysics(),
//       //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       //               crossAxisCount: 4,
//       //               mainAxisSpacing: 10,
//       //               crossAxisSpacing: 10,
//       //               childAspectRatio: 2,
//       //             ),
//       //             itemCount: slots.length,
//       //             itemBuilder: (context, slotIndex) {
//       //               bool isBooked = slotViewModel
//       //                   .slotHistoryModel!.slotHistoryData!.sdata!
//       //                   .where((e) => e.sTime == slots[slotIndex])
//       //                   .isNotEmpty;
//       //               return Container(
//       //                 decoration: BoxDecoration(
//       //                   borderRadius: BorderRadius.circular(5),
//       //                   border: Border.all(
//       //                       width: 1,
//       //                       color: isBooked
//       //                           ? ColorConstant.greyColor
//       //                           : ColorConstant.primaryColor),
//       //                 ),
//       //                 alignment: Alignment.center,
//       //                 child: TextContext(
//       //                   data: "${slots[slotIndex]}",
//       //                   color: isBooked
//       //                       ? ColorConstant.greyColor
//       //                       : ColorConstant.primaryColor,
//       //                   fontWeight: FontWeight.w500,
//       //                   fontFamily: "poppins_reg",
//       //                   fontSize: 12,
//       //                 ),
//       //               );
//       //             },
//       //           ),
//       //         ],
//       //       ),
//       //     );
//       //   },
//       // ),
//     );
//   }
//
// // Function to generate slots
//   List<String> generateSlots(String sTime, String eTime, String sDuration) {
//     print("kdf mke kme rf");
//     print(sTime);
//     print(eTime);
//     final DateFormat timeFormat = DateFormat("hh:mm");
//     final DateTime startTime = timeFormat.parse(sTime);
//     DateTime endTime = timeFormat.parse(eTime);
//
//     // Handle PM/AM boundaries
//     if (endTime.isBefore(startTime)) {
//       endTime = endTime.add(const Duration(hours: 12));
//     }
//
//     print("dsdsk $sDuration");
//     final int slotDuration = int.parse(sDuration);
//     final List<String> slots = [];
//
//     DateTime currentTime = startTime;
//     while (currentTime.isBefore(endTime)) {
//       slots.add(timeFormat.format(currentTime));
//       currentTime = currentTime.add(Duration(minutes: slotDuration));
//     }
//
//     return slots;
//   }
//
// // Helper function to get the icon path based on slot type
//   String getIconPath(int slotType) {
//     switch (slotType) {
//       case 1:
//         return Assets.iconMorning;
//       case 2:
//         return Assets.iconAfternoon;
//       case 3:
//         return Assets.iconEvening;
//       default:
//         return Assets.iconNight;
//     }
//   }
//
//   String getSlotTitle(int slotType) {
//     switch (slotType) {
//       case 1:
//         return "Morning";
//       case 2:
//         return "Afternoon";
//       case 3:
//         return "Evening";
//       default:
//         return "Night";
//     }
//   }
//
//   Widget slotRow({
//     required String iconPath,
//     required String title,
//     required int slotCount,
//     required double width,
//     required String id,
//     required String slotType,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: width * 0.060,
//               child: Image.asset(iconPath),
//             ),
//             const SizedBox(width: 10),
//             RichText(
//               text: TextSpan(
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: "$title ",
//                     style: const TextStyle(
//                         color: Color(0xFF000000),
//                         fontWeight: FontWeight.w500,
//                         fontFamily: "poppins_reg"),
//                   ),
//                   TextSpan(
//                     text: "$slotCount slots",
//                     style: const TextStyle(
//                         color: Color(0xFF7C7979),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: "poppins_reg"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         GestureDetector(
//           onTap: () {
//             showDialog(context: context, builder: (_){
//               return CommonDeletePopup(title: 'Are you sure, you want to delete the selected slot!', yes: () {
//                 Provider.of<SlotViewModel>(context, listen: false)
//                     .deleteSlotApi( id, context);
//               },);
//             });
//           },
//           child: SizedBox(
//             width: width * 0.060,
//             child: Image.asset("assets/icon/maskGroup.png"),
//           ),
//         ),
//       ],
//     );
//   }
// }
