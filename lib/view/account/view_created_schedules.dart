import 'package:doctor_apk/generated/assets.dart';
import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view/account/common_day.dart';
import 'package:doctor_apk/view/account/create_Individual.dart';
import 'package:doctor_apk/view_model/slot_view_model.dart';
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
      final slotProvider = Provider.of<SlotViewModel>(context, listen: false);
      slotProvider.clearClickedIndex();
      slotProvider.getSlotDates(context);
      slotProvider.fetchNext15Days();
    });
  }

  @override
  Widget build(BuildContext context) {
    final slotProvider = Provider.of<SlotViewModel>(context);
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
              color: const Color(0xff1E1E1E),
            )),
        centerTitle: true,
        title: TextContext(
          data:
              "See ${slotProvider.slotType == "1" ? "Individual" : "Common"} Day Schedule",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: const Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: slotProvider.nextDays == null ||
              slotProvider.nextDays!.isEmpty ||
              (slotProvider.slotDateAvailability == null ||
                  slotProvider.slotDateAvailability!.availability!.isEmpty)
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.primaryColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.010,
                  ),
                  Container(
                    width: width,
                    color: ColorConstant.whiteColor,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                        ),
                        Column(
                          children: [
                            Container(
                              width: width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.050,
                                    child: Image.asset(
                                      Assets.iconHome,
                                      color: ColorConstant.buttonBlueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  const TextContext(
                                    data: "Clinic Visit Slot",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    fontFamily: "poppins_reg",
                                    fontSize: 12,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.061,
                              child: ListView.builder(
                                  itemCount: slotProvider.nextDays!.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if (slotProvider.slotDateAvailability ==
                                            null ||
                                        slotProvider.slotDateAvailability!
                                            .availability!.isEmpty) {
                                      return const SizedBox.shrink();
                                    }
                                    final avlSlots = slotProvider
                                        .slotDateAvailability!.availability!
                                        .firstWhere((e) =>
                                            e.weekday!.toLowerCase() ==
                                            DateFormat.EEEE()
                                                .format(slotProvider
                                                    .nextDays![index])
                                                .toLowerCase())
                                        .availableSlots;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: InkWell(
                                        onTap: () {
                                          slotProvider.setClickedDay(
                                              index, context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: width * 0.35,
                                          decoration: BoxDecoration(
                                              color: slotProvider.clickDate ==
                                                      index
                                                  ? ColorConstant.lightGrayColor
                                                  : ColorConstant.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: slotProvider.clickDate ==
                                                      index
                                                  ? Border.all(
                                                      width: 1,
                                                      color: ColorConstant
                                                          .rBorderSideColor)
                                                  : Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xff979797))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextContext(
                                                  data: DateFormat.EEEE()
                                                      .format(slotProvider
                                                          .nextDays![index]),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "poppins_reg",
                                                  color:
                                                      const Color(0xff1E1E1E)),
                                              TextContext(
                                                  data: avlSlots! > 0
                                                      ? "$avlSlots slots available"
                                                      : "No slots available",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: avlSlots > 0
                                                      ? const Color(0xff229505)
                                                      : ColorConstant
                                                          .textColor),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // height: height/1.8,
                    width: width,
                    color: ColorConstant.whiteColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.010,
                        ),
                        TextContext(
                            data: slotProvider.data.toString() == "null"
                                ? ""
                                : DateFormat("EEEE").format(DateTime.parse(
                                    slotProvider.data.toString())),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff1E1E1E)),
                        Container(
                          child: slotProvider.loadSlotData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConstant.primaryColor,
                                  ),
                                )
                              : slotProvider.slotHistoryModel == null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: ButtonConst(
                                        onTap: () {
                                          if(slotProvider.slotType=="1"){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const CreateIndividual()),
                                            );
                                          }else{
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const CreateCommonDaySchedule()),
                                            );
                                          }

                                        },
                                        height: height * 0.06,
                                        alignment: Alignment.center,
                                        borderRadius: BorderRadius.circular(5),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        color: ColorConstant.primaryColor,
                                        label:
                                            "Create Your First schedule now!",
                                        fontSize: 16,
                                      ),
                                    )
                                  : slotList(context),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget slotList(BuildContext context) {
    final slotProvider = Provider.of<SlotViewModel>(context);
    final width = MediaQuery.of(context).size.width;
    return slotProvider.slotHistoryModel!.status == 200
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: ColorConstant.whiteColor,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: slotProvider
                  .slotHistoryModel!.slotHistoryData!.slotdata!.length,
              itemBuilder: (context, index) {
                final slotData = slotProvider
                    .slotHistoryModel!.slotHistoryData!.slotdata![index];
                final List<String> slots = slotProvider.generateSlots(
                    slotData.sTime!, slotData.eTime!, slotData.sDuration!);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              int.parse((width / 5).toStringAsFixed(0)),
                              (index) {
                            return Container(
                              height: 0.6,
                              width: 2,
                              color: ColorConstant.greyColor,
                            );
                          })),
                      AppConstant.spaceHeight25,
                      slotRow(
                        iconPath: getIconPath(slotData.slotType!),
                        title: getSlotTitle(slotData.slotType!),
                        slotCount: slots.length,
                        width: width,
                        id: slotData.id.toString(),
                        slotType: slotData.slotType.toString(),
                      ),
                      AppConstant.spaceHeight20,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                        itemCount: slots.length,
                        itemBuilder: (context, slotIndex) {
                          bool isBooked = slotProvider
                              .slotHistoryModel!.slotHistoryData!.sdata!
                              .where((e) => e.sTime == slots[slotIndex])
                              .isNotEmpty;

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1,
                                  color: isBooked
                                      ? ColorConstant.greyColor
                                      : ColorConstant.primaryColor),
                            ),
                            alignment: Alignment.center,
                            child: TextContext(
                              data: slots[slotIndex],
                              color: isBooked
                                  ? ColorConstant.greyColor
                                  : ColorConstant.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "poppins_reg",
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Container();
  }

  String getIconPath(int slotType) {
    switch (slotType) {
      case 1:
        return Assets.iconMorning;
      case 2:
        return Assets.iconAfternoon;
      case 3:
        return Assets.iconEvening;
      default:
        return Assets.iconNight;
    }
  }

  String getSlotTitle(int slotType) {
    switch (slotType) {
      case 1:
        return "Morning";
      case 2:
        return "Afternoon";
      case 3:
        return "Evening";
      default:
        return "Night";
    }
  }

  Widget slotRow({
    required String iconPath,
    required String title,
    required int slotCount,
    required double width,
    required String id,
    required String slotType,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.060,
              child: Image.asset(iconPath),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "$title ",
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "poppins_reg"),
                  ),
                  TextSpan(
                    text: "$slotCount slots",
                    style: const TextStyle(
                        color: Color(0xFF7C7979),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "poppins_reg"),
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return CommonDeletePopup(
                    title:
                        'Are you sure, you want to delete the selected slot!',
                    yes: () {
                      Provider.of<SlotViewModel>(context, listen: false)
                          .deleteSlotApi(id, context);
                    },
                  );
                });
          },
          child: SizedBox(
            width: width * 0.060,
            child: Image.asset("assets/icon/maskGroup.png"),
          ),
        ),
      ],
    );
  }
}
