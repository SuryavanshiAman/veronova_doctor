import 'package:doctor_apk/generated/assets.dart';
import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/model/view_slot_model.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view/account/common_day.dart';
import 'package:doctor_apk/view/account/create_Individual.dart';
import 'package:doctor_apk/view_model/slot_view_model.dart';
import 'package:doctor_apk/view_model/view_slot_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../res/common_delete_popup.dart';

class SeeBookedAppointment extends StatefulWidget {
  const SeeBookedAppointment({
    super.key,
  });

  @override
  State<SeeBookedAppointment> createState() => _SeeBookedAppointmentState();
}

class _SeeBookedAppointmentState extends State<SeeBookedAppointment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewSlotViewModel>(context,listen: false).viewSlot(context);
      final slotProvider = Provider.of<SlotViewModel>(context, listen: false);
      slotProvider.clearClickedIndex();
      slotProvider.getSlotDates(context);
      slotProvider.fetchNext15Days();
    });
  }
  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat("EEE, dd MMM yyyy").format(date);
  }
  // final List<Map<String, dynamic>> slotViewData = [
  //   {
  //     "date": "2024-07-13",
  //     "slots": [
  //       {
  //         "type": "Morning Slot",
  //         "start_time": "08:30",
  //         "end_time": "10:30",
  //         "duration": "15"
  //       },
  //       {
  //         "type": "Evening Slot",
  //         "start_time": "17:00",
  //         "end_time": "19:00",
  //         "duration": "30"
  //       },
  //     ],
  //   },
  //   {
  //     "date": "2024-07-14",
  //     "slots": [
  //       {
  //         "type": "Night Slot",
  //         "start_time": "20:00",
  //         "end_time": "21:30",
  //         "duration": "20"
  //       }
  //     ],
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final slotViewData = Provider.of<ViewSlotViewModel>(context).viewSlotModelData;
    return Scaffold(
      backgroundColor: ColorConstant.scaffoldBgColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: ColorConstant.whiteColor,
            )),
        centerTitle: true,
        title:  TextContext(
          data:
              "See Individual Day Schedule",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color:ColorConstant.whiteColor,
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: ListView.builder(
        itemCount: slotViewData?.data?.length??0,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final group = slotViewData?.data?[index];
          final String date = group?.date??"";
          final  slots = group?.slots;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🗓 ${formatDate(date)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
               SizedBox(height: 10),
              Column(
                children: List.generate(slots?.length??0, (index){
                  final slot=slots?[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              slot?.type??"",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.teal, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "${slot?.startTime??""} - ${slot?.endTime??""}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.timelapse,
                                color: Colors.orange, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "Duration: ${slot?.duration??""} min",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
              // ...slots.map((slot) => Container(
              //   margin: const EdgeInsets.only(bottom: 15),
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(14),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.05),
              //         blurRadius: 6,
              //         offset: const Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           const Icon(Icons.check_circle,
              //               color: Colors.green, size: 20),
              //           const SizedBox(width: 10),
              //           Text(
              //             slot["type"],
              //             style: const TextStyle(
              //               fontSize: 15,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       Row(
              //         children: [
              //           const Icon(Icons.access_time,
              //               color: Colors.teal, size: 18),
              //           const SizedBox(width: 8),
              //           Text(
              //             "${slot['start_time']} - ${slot['end_time']}",
              //             style: const TextStyle(
              //               fontSize: 14,
              //               color: Colors.black87,
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 6),
              //       Row(
              //         children: [
              //           const Icon(Icons.timelapse,
              //               color: Colors.orange, size: 18),
              //           const SizedBox(width: 8),
              //           Text(
              //             "Duration: ${slot['duration']} min",
              //             style: const TextStyle(
              //               fontSize: 14,
              //               color: Colors.black54,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // )),
              const SizedBox(height: 24),
            ],
          );
        },
      )
      // SingleChildScrollView(
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
      //                             SizedBox(
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
      //                             itemCount: viewSlot?.data?.length,
      //                             shrinkWrap: true,
      //                             scrollDirection: Axis.horizontal,
      //                             itemBuilder: (context, index) {
      //                               final data = viewSlot?.data?[index];
      //                               return Padding(
      //                                 padding: const EdgeInsets.symmetric(
      //                                     horizontal: 10),
      //                                 child: InkWell(
      //                                   onTap: () {
      //                                     slotProvider.setClickedDay(index, context);
      //                                   },
      //                                   child: Container(
      //                                     alignment: Alignment.center,
      //                                     width: width * 0.35,
      //                                     decoration: BoxDecoration(
      //                                         color: slotProvider.clickDate ==
      //                                                 index
      //                                             ? ColorConstant.lightGrayColor
      //                                             : ColorConstant.whiteColor,
      //                                         borderRadius:
      //                                             BorderRadius.circular(5),
      //                                         border: slotProvider.clickDate ==
      //                                                 index
      //                                             ? Border.all(
      //                                                 width: 1,
      //                                                 color: ColorConstant
      //                                                     .rBorderSideColor)
      //                                             : Border.all(
      //                                                 width: 1,
      //                                                 color: const Color(
      //                                                     0xff979797))),
      //                                     child: Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.center,
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.center,
      //                                       children: [
      //                                         TextContext(
      //                                             data: data?.weekDay??"",
      //                                             fontSize: 14,
      //                                             fontWeight: FontWeight.w500,
      //                                             fontFamily: "poppins_reg",
      //                                             color:
      //                                                 const Color(0xff1E1E1E)),
      //                                         const TextContext(
      //                                             data:"slots available",
      //                                             fontSize: 12,
      //                                             fontWeight: FontWeight.w400,
      //                                             color: Color(0xff229505),)
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
      //
      //           ],
      //         ),
      //       ),
    );
  }

}
// import 'package:flutter/material.dart';


class SlotGroupedViewScreen extends StatelessWidget {

   SlotGroupedViewScreen({super.key,});

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat("EEE, dd MMM yyyy").format(date);
  }
  final List<Map<String, dynamic>> slotViewData = [
    {
      "date": "2024-07-13",
      "slots": [
        {
          "type": "Morning Slot",
          "start_time": "08:30",
          "end_time": "10:30",
          "duration": "15"
        },
        {
          "type": "Evening Slot",
          "start_time": "17:00",
          "end_time": "19:00",
          "duration": "30"
        },
      ],
    },
    {
      "date": "2024-07-14",
      "slots": [
        {
          "type": "Night Slot",
          "start_time": "20:00",
          "end_time": "21:30",
          "duration": "20"
        }
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Your Slot Schedule"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: slotViewData.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final group = slotViewData[index];
          final String date = group["date"];
          final List slots = group["slots"];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🗓 ${formatDate(date)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              ...slots.map((slot) => Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          slot["type"],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: Colors.teal, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "${slot['start_time']} - ${slot['end_time']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.timelapse,
                            color: Colors.orange, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "Duration: ${slot['duration']} min",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
