import 'dart:convert';

import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';

import 'package:doctor_apk/view_model/slot_view_model.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class CreateCommonDaySchedule extends StatefulWidget {
  const CreateCommonDaySchedule({super.key});

  @override
  State<CreateCommonDaySchedule> createState() =>
      _CreateCommonDayScheduleState();
}

int currentIndex = -1;

class _CreateCommonDayScheduleState extends State<CreateCommonDaySchedule> {
  bool currentValue = false;

  // List<Map<String, dynamic>> individualDaySchedule = [
  //   {
  //     "type_id": "1",
  //     "title": 'Morning Slot',
  //     "img": "assets/icon/morning.png",
  //     "imgTime": "assets/icon/time.png",
  //     "dateTime": DateTime.now(),
  //     "start_time": '08:30',
  //     "end_time": '11:00',
  //     "rightImg": 'assets/icon/right.png',
  //     "isChecked": false,
  //     "slotDuration": [
  //       {"duration": '10', "isSelect": false},
  //       {"duration": '15', "isSelect": false},
  //       {"duration": '20', "isSelect": false},
  //       {"duration": '25', "isSelect": false},
  //       {"duration": '30', "isSelect": false},
  //     ]
  //   },
  //   {
  //     "type_id": "2",
  //     "title": 'Afternoon Slot',
  //     "img": "assets/icon/afternoon.png",
  //     "imgTime": "assets/icon/time.png",
  //     "dateTime": DateTime.now(),
  //     "start_time": '13:00',
  //     "end_time": '15:00',
  //     "rightImg": 'assets/icon/right.png',
  //     "isChecked": false,
  //     "slotDuration": [
  //       {"duration": '10', "isSelect": false},
  //       {"duration": '15', "isSelect": false},
  //       {"duration": '20', "isSelect": false},
  //       {"duration": '25', "isSelect": false},
  //       {"duration": '30', "isSelect": false},
  //     ]
  //   },
  //   {
  //     "type_id": "3",
  //     "title": 'Evening Slot',
  //     "img": "assets/icon/evening.png",
  //     "imgTime": "assets/icon/time.png",
  //     "dateTime": DateTime.now(),
  //     "start_time": '16:30',
  //     "end_time": '18:00',
  //     "rightImg": 'assets/icon/right.png',
  //     "isChecked": false,
  //     "slotDuration": [
  //       {"duration": '10', "isSelect": false},
  //       {"duration": '15', "isSelect": false},
  //       {"duration": '20', "isSelect": false},
  //       {"duration": '25', "isSelect": false},
  //       {"duration": '30', "isSelect": false},
  //     ]
  //   },
  //   {
  //     "type_id": "4",
  //     "title": 'Night Slot',
  //     "img": "assets/icon/night.png",
  //     "imgTime": "assets/icon/time.png",
  //     "dateTime": DateTime.now(),
  //     "start_time": '19:00',
  //     "end_time": '21:30',
  //     "rightImg": 'assets/icon/right.png',
  //     "isChecked": false,
  //     "slotDuration": [
  //       {"duration": '10', "isSelect": false},
  //       {"duration": '15', "isSelect": false},
  //       {"duration": '20', "isSelect": false},
  //       {"duration": '25', "isSelect": false},
  //       {"duration": '30', "isSelect": false},
  //     ]
  //   },
  // ];

  // Future<void> _selectTime(BuildContext context, int index, String key) async {
  //   final slotCon = Provider.of<SlotViewModel>(context, listen: false);
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (picked != null) {
  //     final DateTime selectedTime = DateTime(
  //       DateTime.now().year,
  //       DateTime.now().month,
  //       DateTime.now().day,
  //       picked.hour,
  //       picked.minute,
  //     );
  //
  //     String formattedTime = formatTo12Hour(selectedTime);
  //
  //     setState(() {
  //       individualDaySchedule[index][key] = formattedTime;
  //     });
  //
  //     if (kDebugMode) {
  //       print("Selected time: $formattedTime");
  //     }
  //   }
  // }
  //
  // // String formatTo12Hour(DateTime dateTime) {
  // //   return DateFormat.jm().format(dateTime);
  // // }

  late List<bool> isSelected;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SlotViewModel>(context, listen: false).clearClickedIndex();
    });
    isSelected = List.generate(
        Provider.of<SlotViewModel>(context, listen: false).weekend.length,
        (_) => false);
  }

  List<String> selectedIndexes = [];
  @override
  Widget build(BuildContext context) {
    final slotProvider = Provider.of<SlotViewModel>(context);
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () async {
          UserViewModel userViewModel = UserViewModel();
          String? userId = await userViewModel.getUser();
          setState(() {
            slotProvider.selectedSlotsData = [];
            for (var scheduleData in slotProvider.individualDaySchedule) {
              if (scheduleData["isChecked"] == true) {
                for (var selectedScheduleData in scheduleData["slotDuration"]) {
                  if (selectedScheduleData["isSelect"] == true) {
                    slotProvider.selectedSlotsData.add({
                      "slot_type": scheduleData["type_id"],
                      "s_time": scheduleData["start_time"],
                      "e_time": scheduleData["end_time"],
                      "s_duration": selectedScheduleData["duration"]
                    });
                  } else {
                    debugPrint(
                        "no time slot selected for ${scheduleData['title']}");
                  }
                }
              } else {
                debugPrint("it is not selected");
              }
            }
            // print("selected slot detail: ${slotProvider.selectedSlotsData}");
            if (kDebugMode) {
              print(
                  "selected slot detail: ${jsonEncode(slotProvider.selectedSlotsData)}");
              print("selected slot type: ${slotProvider.selectedSlotsData}");
            }
            // final encodedSlotData = jsonEncode(slotProvider.selectedSlotsData);

            final completeSlotDataFormat = {
              "doctor_id": userId,
              "slot_type_id": "2",
              "week_day":
                  selectedIndexes.map((day) => day.toLowerCase()).join(','),
              "slot_data": slotProvider.selectedSlotsData
            };
            print("all encoded data: ${jsonEncode(completeSlotDataFormat)}");

            if (slotProvider.selectedSlotsData.isEmpty) {
              Utils.show("Please Select Slot", context);
            } else
              slotProvider.slotApi(context, completeSlotDataFormat);
          });
        },
        child: ButtonConst(
          loading: slotProvider.loading,
          color: ColorConstant.primaryColor,
          alignment: Alignment.center,
          label: "Generate Slots",
          fontSize: 18,
          width: width,
          height: height * 0.060,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: ColorConstant.scaffoldBgColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: const Color(0xff1E1E1E),
            )),
        centerTitle: true,
        title: const TextContext(
          data: "Create Common Day Schedule",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: const TextContext(
                      data: "Select Weekday",
                      fontWeight: FontWeight.w400,
                      color: Color(0xff444343),
                      fontSize: 14,
                      fontFamily: "poppins_reg"),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: height * 0.10,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: slotProvider.weekend.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected[index] = !isSelected[index];

                                if (isSelected[index]) {
                                  selectedIndexes
                                      .add(slotProvider.weekend[index]);
                                } else {
                                  selectedIndexes
                                      .remove(slotProvider.weekend[index]);
                                }
                              });
                            },
                            child: Column(children: [
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  color: isSelected[index]
                                      ? ColorConstant.lightGrayColor
                                      : ColorConstant.whiteColor,
                                  border: Border.all(
                                      width: 1,
                                      color: isSelected[index]
                                          ? ColorConstant.rBorderSideColor
                                          : const Color(0xff979797)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                height: height * 0.048,
                                child: TextContext(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff1E1E1E),
                                  fontFamily: "poppins_reg",
                                  data: slotProvider.weekend[index],
                                ),
                              ),
                            ]));
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentValue = !currentValue;

                            if (selectedIndexes.length ==
                                slotProvider.weekend.length) {
                              selectedIndexes.clear();
                              isSelected = List.generate(7, (_) => false);
                            } else {
                              selectedIndexes = List.from(slotProvider.weekend);
                              isSelected = List.generate(7, (_) => true);
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/right.png",
                              width: 20,
                              color: currentValue && selectedIndexes.isNotEmpty
                                  ? const Color(0xff229505)
                                  : const Color(0xffD1CDCD),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const TextContext(
                          data: "Select all day",
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1E1E1E),
                          fontSize: 14,
                          fontFamily: "poppins_reg"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: slotProvider.individualDaySchedule.length,
            itemBuilder: (_, int i) {
              final data = slotProvider.individualDaySchedule[i];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 5, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Image.asset(
                        data["img"],
                        width: 20,
                        height: 20,
                        color: const Color(0xff9F9F9F),
                      ),
                      title: GestureDetector(
                        onTap: () {
                          setState(() {
                            data["isChecked"] = !data["isChecked"];
                          });
                        },
                        child: Row(
                          children: [
                            TextContext(
                                data: data["title"],
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff000000),
                                fontSize: 14,
                                fontFamily: "poppins_reg"),
                            AppConstant.spaceWidth10,
                            Image.asset(data["rightImg"],
                                width: 20,
                                color: data["isChecked"] == false
                                    ? const Color(0xffD1CDCD)
                                    : const Color(0xff229505))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextContext(
                      data: "TIME",
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                      fontFamily: "poppins_reg",
                      fontSize: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            slotProvider.selectTime(context, i, "start_time");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: const Color(0xffD1CDCD)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: height * 0.040,
                            width: width * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data["start_time"]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444343),
                                    fontFamily: "poppins_reg",
                                    fontSize: 12,
                                  ),
                                ),
                                Image.asset(
                                  data["imgTime"],
                                  height: height * 0.025,
                                  width: height * 0.025,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            slotProvider.selectTime(context, i, "end_time");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.2),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: height * 0.040,
                            width: width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data["end_time"]}",
                                  style: const TextStyle(
                                      color: Color(0xff444343),
                                      fontFamily: "poppins_reg",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Image.asset(
                                  data["imgTime"],
                                  height: height * 0.025,
                                  width: height * 0.025,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                    const TextContext(
                      data: "Slot Duration :",
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins_reg",
                      color: Color(0xff000000),
                      fontSize: 14,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data["slotDuration"].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: (width / 2) / (height * 0.1),
                        mainAxisSpacing: height * 0.01,
                        crossAxisSpacing: width * 0.11,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final slotData = data["slotDuration"][index];
                        return GestureDetector(
                          onTap: () {
                            if (data["isChecked"]) {
                              setState(() {
                                for (var item in data["slotDuration"]) {
                                  item["isSelect"] = false;
                                }
                                slotData["isSelect"] = true;
                              });
                            } else {
                              Utils.show("Please Select Slot", context);
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icon/right.png",
                                width: 20,
                                color: slotData["isSelect"] == false
                                    ? const Color(0xffD1CDCD)
                                    : ColorConstant.primaryColor,
                              ),
                              AppConstant.spaceWidth10,
                              Text(
                                "${slotData["duration"]}min",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff1E1E1E),
                                    fontSize: 13,
                                    fontFamily: "poppins_reg"),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.08,
          ),
        ],
      ),
    );
  }
}
