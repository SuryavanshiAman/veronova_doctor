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

  @override
  Widget build(BuildContext context) {
    final slotProvider = Provider.of<SlotViewModel>(context);
    final viewSlot = Provider.of<ViewSlotViewModel>(context).viewSlotModelData;
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
        title: const TextContext(
          data:
              "See Individual Day Schedule",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body:
      SingleChildScrollView(
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
                                  itemCount: viewSlot?.data?.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final data = viewSlot?.data?[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: InkWell(
                                        onTap: () {
                                          slotProvider.setClickedDay(index, context);
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
                                                  data: data?.weekDay??"",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "poppins_reg",
                                                  color:
                                                      const Color(0xff1E1E1E)),
                                              const TextContext(
                                                  data:"slots available",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff229505),)
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

                ],
              ),
            ),
    );
  }

}
