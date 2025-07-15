import 'dart:convert';
import 'dart:developer';

import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/date_picker.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/slot_view_model.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class CreateIndividual extends StatefulWidget {
  const CreateIndividual({super.key});

  @override
  State<CreateIndividual> createState() => _CreateIndividualState();
}

class _CreateIndividualState extends State<CreateIndividual> {
  int? selectedIndex;
  bool allDay = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<SlotViewModel>(context, listen: false).clearClickedIndex();
    });
  }
  DateTime selectedDate = DateTime.now();
  DateTime? _selectedDate;
  TextEditingController dotCont = TextEditingController();
  bool showSelectedDate = false;
  void _handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      dotCont.text = formattedDate();
      showSelectedDate = true;

    });
  }
  String formattedDate() {

    final String year = selectedDate.year.toString();
    final String month = selectedDate.month.toString().padLeft(2, '0');
    final String day = selectedDate.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: generateSlotButton(),
      backgroundColor: ColorConstant.scaffoldBgColor,
      appBar: appBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          AppConstant.spaceHeight10,
          // weekDayUi(),
          AppConstant.spaceHeight5,
          slotDateBookModelUi(),
          AppConstant.spaceHeight5,
          slotTimeBookModelUi(),
          SizedBox(
            height: height * 0.08,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
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
        data: "Create Individual Day Schedule",
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: ColorConstant.whiteColor,
      ),
      backgroundColor: ColorConstant.containerFillColor,
    );
  }

  Widget weekDayUi() {
    final slotProvider = Provider.of<SlotViewModel>(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: const TextContext(
              data: "Select Weekday",
              fontWeight: FontWeight.w600,
              color: Color(0xff444343),
              fontSize: 14,
            ),
          ),
          AppConstant.spaceHeight5,
          SizedBox(
            height: height * 0.080,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: slotProvider.weekend.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        AppConstant.spaceHeight5,
                        Container(
                          alignment: Alignment.center,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: currentIndex == index || allDay == true
                                ? ColorConstant.lightGrayColor
                                : ColorConstant.whiteColor,
                            border: Border.all(
                                width: 1,
                                color: currentIndex == index || allDay == true
                                    ? ColorConstant.rBorderSideColor
                                    : const Color(0xff979797)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          height: height * 0.048,
                          child: TextContext(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff1E1E1E),
                            fontFamily: "poppins_reg",
                            data: slotProvider.weekend[index],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget slotDateBookModelUi() {
    final slotProvider = Provider.of<SlotViewModel>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextContext(
              data: "Select Date",
              fontWeight: FontWeight.w500,
              color: const Color(0xff000000),
              fontSize: 14,
              fontFamily: "poppins_reg"),
          SizedBox(height: 10,),
          DobWidget(
            controller: dotCont,
            initialDate: selectedDate,
            onDateSelected: _handleDateSelected,
          ),

        ],
      ),
    );
  }
  Widget slotTimeBookModelUi() {
    final slotProvider = Provider.of<SlotViewModel>(context);
    return ListView.builder(
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
                  color: const Color(0xff9F9F9F),
                  height: 20,
                ),
                title: GestureDetector(
                  onTap: () {
                    slotProvider.setSlotTypeTime(i);
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
              const TextContext(
                data: "Time",
                fontWeight: FontWeight.w400,
                color: Color(0xff000000),
                fontFamily: "poppins_reg",
                fontSize: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () =>
                        slotProvider.selectTime(context, i, "start_time"),
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
                    onTap: () =>
                        slotProvider.selectTime(context, i, "end_time"),
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
                    // onTap: () {
                    //   if (data["isChecked"]) {
                    //     setState(() {
                    //       // Deselect all items
                    //       for (var item in data["slotDuration"]) {
                    //         item["isSelect"] = false;
                    //       }
                    //       // Select the tapped item
                    //       slotData["isSelect"] = true;
                    //     });
                    //   } else {
                    //     Utils.show("Please Select Slot", context);
                    //   }
                    // },
                    onTap: () {
                      if (data["isChecked"]) {
                        setState(() {
                          // Deselect all items
                          for (var item in data["slotDuration"]) {
                            item["isSelect"] = false;
                          }
                          // Select the tapped item
                          slotData["isSelect"] = true;
                        });

                        // Call method to update selectedSlotsData
                        slotProvider.addSelectedSlot(
                          typeId: data["type_id"],
                          title: data["title"],
                          startTime: data["start_time"],
                          endTime: data["end_time"],
                          duration: slotData["duration"],
                        );
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
                          "${slotData["duration"]} min",
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
    );
  }
  Widget generateSlotButton() {
    final slotProvider = Provider.of<SlotViewModel>(context);
    return ButtonConst(
      loading: slotProvider.loading,
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
        UserViewModel userViewModel = UserViewModel();
        String? userId = await userViewModel.getUser();

        final slotData = slotProvider.selectedSlotsData;
        if (slotData.isEmpty) {
          Utils.show("Please select at least one slot", context);
          return;
        }

        final completeSlotDataFormat = {
          "doctor_id": userId,
          // "week_day": slotProvider.weekend[currentIndex].toString().toLowerCase(),
          "week_day":dotCont.text,
          "slots": slotData,
        };

        log("=== Selected Slots ===");
        for (var slot in slotData) {
          log("Title: ${slot['title']}, Time: ${slot['start_time']} - ${slot['end_time']}, Duration: ${slot['duration']} min");
        }
log("=======${completeSlotDataFormat}");
        // Proceed to API call
        slotProvider.slotApi(context, completeSlotDataFormat);
        slotProvider.selectedSlotsData.clear();
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
