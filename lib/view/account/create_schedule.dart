import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/view/account/create_Individual.dart';
import 'package:doctor_apk/view/account/view_created_schedules.dart';
import 'package:doctor_apk/view_model/slot_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../res/color_constant.dart';
import '../../res/text_context.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color:ColorConstant.whiteColor,
            )),
        centerTitle: true,
        title:  TextContext(
          data: "Create Schedule",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: ColorConstant.whiteColor,
        ),
        backgroundColor: ColorConstant.lightGrayColor,
      ),
      body: Column(
        children: [
          buttonTile(
              "Create Individual Day Schedule",
              "Create Individual schedule for each day",
              const CreateIndividual()),
          buttonTile("See", "See Individual schedule for each day",
              const SeeBookedAppointment() ,isAllowDarkBorder: true, slotType: "1"),
        ],
      ),
    );
  }

  Widget buttonTile(String title, String subTitle, Widget page,
      {bool isAllowDarkBorder = false,String slotType =""}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ColorConstant.lightGrayColor,
        border: Border.all(
          width: 1,
          color: isAllowDarkBorder
              ? ColorConstant.buttonBlueColor
              : ColorConstant.rBorderSideColor,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      alignment: Alignment.center,
      child: ListTile(
        onTap: () {
          Provider.of<SlotViewModel>(context, listen: false).setSlotType(slotType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        title: TextContext(
          data: title,
          fontSize: AppConstant.fontSizeTwo,
          fontWeight: FontWeight.w600,
          color:ColorConstant.whiteColor,
          fontFamily: "poppins_reg",
        ),
        subtitle: TextContext(
          data: subTitle,
          fontSize: AppConstant.fontSizeOne,
          fontWeight: FontWeight.w500,
          color: ColorConstant.whiteColor,
          fontFamily: "poppins_reg",
        ),
        trailing: SizedBox(
          height: height * 0.040,
          width: height * 0.040,
          child: Image.asset(
            "assets/icon/arrowIndi.png",
            color:ColorConstant.whiteColor,
          ),
        ),
      ),
    );
  }
}
