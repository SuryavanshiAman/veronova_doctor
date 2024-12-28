import 'dart:convert';

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
import 'package:intl/intl.dart';
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
          weekDayUi(),
          AppConstant.spaceHeight5,
          // slotBookModelUi(),
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
            color: const Color(0xff1E1E1E),
          )),
      centerTitle: true,
      title: const TextContext(
        data: "Create Individual Day Schedule",
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color(0xff1E1E1E),
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

  // Widget slotBookModelUi() {
  //   final slotProvider = Provider.of<SlotViewModel>(context);
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     color: Colors.white,
  //     margin: const EdgeInsets.only(bottom: 5, top: 5),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         TextContext(
  //             data: "Select Date",
  //             fontWeight: FontWeight.w500,
  //             color: const Color(0xff000000),
  //             fontSize: 14,
  //             fontFamily: "poppins_reg"),
  //         SizedBox(height: 10,),
  //         DobWidget(
  //           controller: dotCont,
  //           initialDate: selectedDate,
  //           onDateSelected: _handleDateSelected,
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

  Widget generateSlotButton() {
    final slotProvider = Provider.of<SlotViewModel>(context);
    return ButtonConst(
      loading: slotProvider.loading,
      onTap: () async {
        UserViewModel userViewModel = UserViewModel();
        String? userId = await userViewModel.getUser();
        setState(() {
          slotProvider.selectedSlotsData = [];
          if (kDebugMode) {
            print(
                "selected slot detail: ${jsonEncode(slotProvider.selectedSlotsData)}");
          }
          final completeSlotDataFormat = {
            "doctor_id": userId,
            "week_day": slotProvider.weekend[currentIndex].toString().toLowerCase(),
          };
          if (slotProvider.weekend[currentIndex].isEmpty) {
            Utils.show("Please Select Slot", context);
          } else {
            slotProvider.slotApi(context, completeSlotDataFormat);
          }
        });
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
