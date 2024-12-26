import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/make_call.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/appointment_view_model.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = -1;
bool meeting = false;
  @override
  void initState() {
    super.initState();
    final appointmentViewModel =
        Provider.of<AppointmentViewModel>(context, listen: false);
    appointmentViewModel.currentAppointmentApi(context);
    Provider.of<ProfileViewModel>(context, listen: false).doctorCatApi(context);
  }
TextEditingController meetingCont =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appointmentViewModel = Provider.of<AppointmentViewModel>(context);
    final documentVerifyViewModel =
        Provider.of<DocumentVerifyViewModel>(context);
    return Scaffold(
      backgroundColor: ColorConstant.scaffoldBgColor,
      body: RefreshIndicator(
        onRefresh: () async {
          print("Refresh triggered");
          await appointmentViewModel.currentAppointmentApi(context);
          print(
              "Data updated: ${appointmentViewModel.currentAppointmentsModel}");
        },
        child: Consumer<AppointmentViewModel>(
            builder: (context, appointmentViewModel, child) {
          if (appointmentViewModel.currentAppointmentsModel == null ||
              appointmentViewModel
                  .currentAppointmentsModel!.currentAppointmentsData!.isEmpty) {
            return noDataAvl();
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: appointmentViewModel
                  .currentAppointmentsModel!.currentAppointmentsData!.length,
              itemBuilder: (context, index) {
                final appointmentData = appointmentViewModel
                    .currentAppointmentsModel!
                    .currentAppointmentsData![index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  margin: EdgeInsets.only(
                      top: 10,
                      bottom: index ==
                              appointmentViewModel.currentAppointmentsModel!
                                      .currentAppointmentsData!.length -
                                  1
                          ? 10
                          : 0),
                  color: ColorConstant.whiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              const TextSpan(
                                  text: "Appointment ID : ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff1E1E1E),
                                      fontFamily: "poppins_reg",
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: appointmentViewModel
                                      .currentAppointmentsModel!
                                      .currentAppointmentsData![index]
                                      .id
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff000000),
                                      fontFamily: "poppins_reg",
                                      fontWeight: FontWeight.w600))
                            ])),
                            Image.asset(
                              "assets/img/trangale.png",
                              scale: 4,
                            )
                          ],
                        ),
                      ),
                      AppConstant.spaceHeight5,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(100, (context) {
                            return TextContext(
                              data: ".",
                              color: ColorConstant.greyColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w100,
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width * 0.2,
                            child: Image.asset(
                              "assets/img/profile.png",
                              scale: 3,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appointmentInfo("Name", appointmentData.patientName),
                              appointmentInfo("Phone", appointmentData.phone.toString()),
                              appointmentInfo("Patient Age", appointmentData.age.toString()),
                              appointmentInfo("Requested Time", "${DateFormat('EE, dd MMM').format(DateTime.parse(appointmentData.date))}, ${appointmentData.sTime}"),
                              appointmentInfo("Payment Mode", appointmentData.status ==
                                  "0"
                                  ? "Online Payment"
                                  : "Offline Payment",),
                              appointmentInfo("Meeting Time","22/14/24 5:00 pm"),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(100, (context) {
                            return TextContext(
                              data: ".",
                              color: ColorConstant.greyColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w100,
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/map.png",
                              scale: 5,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            TextContext(
                                data: appointmentViewModel
                                    .currentAppointmentsModel!
                                    .currentAppointmentsData![index]
                                    .address
                                    .toString(),
                                fontSize: 14,
                                color: const Color(0xff979797),
                                fontFamily: "poppins_reg",
                                fontWeight: FontWeight.w400),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: const TextContext(
                                  data: ".",
                                  fontSize: 18,
                                )),
                            const TextContext(
                              data: " ₹ ",
                            ),
                            TextContext(
                                data:appointmentViewModel.currentAppointmentsModel!.currentAppointmentsData![index].fees.toString(),
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontFamily: "poppins_reg",
                                fontWeight: FontWeight.w500),
                            const TextContext(
                                data: " Consultation Fees",
                                fontSize: 14,
                                color: Color(0xff000000),
                                fontFamily: "poppins_reg",
                                fontWeight: FontWeight.w500),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                      alignment: Alignment.center,
                                      // backgroundColor: Colors.transparent,
                                      content: Container(
                                        padding: const EdgeInsets.all(15),
                                        height: height*0.25,
                                        child: Column(
                                          children: [
                                             TextContext(
                                                data: "Meeting!",
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                                fontFamily: "poppins_reg",
                                                fontWeight: FontWeight.w500),
                                            SizedBox(height: height*0.03,),
                                            TextfieldContext(
                                              controller: meetingCont,
                                              enabled: true,
                                              filled: true,
                                              fillColor: ColorConstant.whiteColor,

                                              intBorder:true,
                                              hintText: "Enter meeting link.",
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // const Text("Cancel"),
                                                InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: ColorConstant.redColor,
                                                        ),
                                                        alignment: Alignment.center,
                                                        height: height*0.05,
                                                        width: width*0.25,
                                                        // color: Colors.green,
                                                        child:TextContext(
                                                            data: "Cancel",
                                                            fontSize: 12,
                                                            color: ColorConstant.whiteColor,
                                                            fontFamily: "poppins_reg",
                                                            fontWeight: FontWeight.w600),)),
                                                InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        meeting=true;
                                                      });
                                                      Navigator.of(context).pop();
                                                      Utils.show("Meeting link send successfully", context);
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: ColorConstant.primaryColor,
                                                        ),
                                                        alignment: Alignment.center,
                                                        height: height*0.05,
                                                        width: width*0.25,
                                                        // color: Colors.green,
                                                        child:TextContext(
                                                            data: "Submit",
                                                            fontSize: 12,
                                                            color: ColorConstant.whiteColor,
                                                            fontFamily: "poppins_reg",
                                                            fontWeight: FontWeight.w600),))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                );
                              },
                              child: SizedBox(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1,
                                        color:
                                        ColorConstant.greenColor),
                                  ),
                                  alignment: Alignment.center,
                                  height: height * 0.045,
                                  width: width * 0.3,
                                  child: TextContext(
                                    fontSize: 13,
                                    data:meeting==false? "Meeting":"Start",
                                    color: ColorConstant.greenColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        width: width,
                        child: appointmentViewModel.currentAppointmentsModel!
                                    .currentAppointmentsData![index].status
                                    .toString() ==
                                "0"
                            ? acceptRejectButton(appointmentViewModel
                                .currentAppointmentsModel!
                                .currentAppointmentsData![index]
                                .id
                                .toString())
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  appointmentViewModel
                                              .currentAppointmentsModel!
                                              .currentAppointmentsData![index]
                                              .status
                                              .toString() ==
                                          "1"
                                      ? GestureDetector(
                                          onTap: () {
                                            documentVerifyViewModel.statusUpdateApi(
                                                appointmentViewModel
                                                    .currentAppointmentsModel!
                                                    .currentAppointmentsData![
                                                        index]
                                                    .id
                                                    .toString(),
                                                "2",
                                                context);
                                          },
                                          child:documentVerifyViewModel.loadingUpdate && documentVerifyViewModel.selectedIndexAppointmentId.toString() ==  appointmentViewModel
                                              .currentAppointmentsModel!
                                              .currentAppointmentsData![
                                          index]
                                              .id.toString()?  Container(
                                              alignment: Alignment.center,
                                              height: height * 0.045,
                                              width: width * 0.4,
                                              child: CircularProgressIndicator(color: ColorConstant.primaryColor,)):
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      ColorConstant.greenColor),
                                            ),
                                            alignment: Alignment.center,
                                            height: height * 0.045,
                                            width: width * 0.4,
                                            child: TextContext(
                                              fontSize: 13,
                                              data: "Attended",
                                              color: ColorConstant.greenColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      : const Text(''),
                                  InkWell(
                                    onTap: (){
                                      MakeCall.openDialPad(appointmentViewModel
                                          .currentAppointmentsModel!
                                          .currentAppointmentsData![
                                      index].phone.toString());
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: ColorConstant.primaryColor,
                                        ),
                                        alignment: Alignment.center,
                                        width: width * 0.4,
                                        height: height * 0.045,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon/reqDail.png",
                                              color: ColorConstant.whiteColor,
                                              scale: 6.5,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const TextContext(
                                              fontWeight: FontWeight.w500,
                                              data: "Contact",
                                              fontSize: 14,
                                              color: Color(0xffffffff),
                                              fontFamily: "poppins_reg",
                                            )
                                          ],
                                        )),
                                  )
                                ],
                              ),
                      )
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }

  Widget appointmentInfo(String key, String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width/3,
          child: TextContext(
              maxLines: 1,
              data: key,
              fontSize: 14,
              color: const Color(0xff1E1E1E),
              fontFamily: "poppins_reg",
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          width: 10,
          child: TextContext(
              data: ": ",
              fontSize: 14,
              color: Color(0xff1E1E1E),
              fontFamily: "poppins_reg",
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: width/2.5,
          child: TextContext(
              maxLines: 1,
              data:value,
              fontSize: 14,
              color: const Color(0xff444343),
              fontFamily: "poppins_reg",
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget acceptRejectButton(String appointmentId) {
    final documentVerifyViewModel =
        Provider.of<DocumentVerifyViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            documentVerifyViewModel.statusUpdateApi(
                appointmentId, "1", context);
          },
          child:documentVerifyViewModel.loadingUpdate && documentVerifyViewModel.selectedIndexAppointmentId.toString() == appointmentId?  Container(
              alignment: Alignment.center,
              height: height * 0.045,
              width: width * 0.4,
              child: CircularProgressIndicator(color: ColorConstant.primaryColor,)): Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: ColorConstant.orangeColor),
            ),
            alignment: Alignment.center,
            height: height * 0.045,
            width: width * 0.4,
            child:  const TextContext(
              fontSize: 13,
              data: "Accept",
              color: Color(0xffF3A103),
              fontFamily: "poppins_reg",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            documentVerifyViewModel.statusUpdateApi(
                appointmentId, "3", context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  // width: 1, color: ColorConstant.greenColor),
                  // Border.all(
                  width: 1,
                  color: ColorConstant.redColor),
            ),
            alignment: Alignment.center,
            height: height * 0.045,
            width: width * 0.4,
            child: const TextContext(
              fontSize: 13,
              data: "Reject",
              color: ColorConstant.redColor,
              fontFamily: "poppins_reg",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget noDataAvl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.055,
          ),
          const TextContext(
            data: "Nothing is here.",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff1E1E1E),
          ),
          const TextContext(
            data: "Create your appointment schedule now !",
            fontWeight: FontWeight.w400,
            color: Color(0xff444343),
            fontSize: 14,
          ),
          SizedBox(
            height: height * 0.2,
          ),
          Container(
            height: height * 0.26,
            width: width,
            alignment: Alignment.center,
            child: Image.asset(
              "assets/img/appointDoctor.png",
              scale: 4.7,
            ),
          ),
        ],
      ),
    );
  }
}
