import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/make_call.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/appointment_view_model.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:doctor_apk/view_model/meeting_view_model.dart';
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

  TextEditingController meetingCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appointmentViewModel = Provider.of<AppointmentViewModel>(context);
    final submit = Provider.of<MeetingViewModel>(context);
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
              appointmentViewModel.currentAppointmentsModel!.data!.isEmpty) {
            return noDataAvl();
          }
          return appointmentViewModel.currentAppointmentsModel!.data!.isEmpty
              ? noDataAvl()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: appointmentViewModel
                      .currentAppointmentsModel!.data!.length,
                  itemBuilder: (context, index) {
                    final appointmentData = appointmentViewModel
                        .currentAppointmentsModel!.data![index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      margin: EdgeInsets.only(
                          top: 10,
                          bottom: index ==
                                  appointmentViewModel.currentAppointmentsModel!
                                          .data!.length -
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
                                      text: appointmentData.id.toString(),
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
                                  appointmentInfo("Name", appointmentData.name),
                                  appointmentInfo("Phone",
                                      appointmentData.mobile.toString()),
                                  appointmentInfo("Patient Age",
                                      appointmentData.patientAge.toString()),
                                  appointmentInfo("Patient Gender",
                                      appointmentData.patientGender.toString()),
                                  appointmentInfo("Requested Time",
                                      "${DateFormat('EE, dd MMM').format(DateTime.parse(appointmentData.updatedAt))}"),
                                  appointmentInfo(
                                    "Payment Mode",
                                    "Online Payment",
                                  ),
                                  appointmentInfo(
                                      "Meeting Time", "22/14/24 5:00 pm"),
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
                                        .data![index]
                                        .name
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
                                    data: appointmentViewModel
                                        .currentAppointmentsModel!
                                        .data![index]
                                        .doctorFees
                                        .toString(),
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
                            child: appointmentViewModel
                                        .currentAppointmentsModel!
                                        .data![index]
                                        .status
                                        .toString() ==
                                    "0"
                                ? acceptRejectButton(appointmentViewModel
                                    .currentAppointmentsModel!.data![index].id
                                    .toString())
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      appointmentViewModel.currentAppointmentsModel!.data![index].status.toString() == "1"
                                          ? GestureDetector(
                                              onTap: () {
                                                documentVerifyViewModel
                                                    .statusUpdateApi(appointmentViewModel.currentAppointmentsModel!.data![index].id.toString(),
                                                        "2",
                                                        context);
                                              },
                                              child: documentVerifyViewModel
                                                          .loadingUpdate &&
                                                      documentVerifyViewModel
                                                              .selectedIndexAppointmentId
                                                              .toString() ==
                                                          appointmentViewModel
                                                              .currentAppointmentsModel!
                                                              .data![index]
                                                              .id
                                                              .toString()
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: height * 0.045,
                                                      width: width * 0.4,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: ColorConstant
                                                            .primaryColor,
                                                      ))
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: ColorConstant
                                                                .greenColor),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      height: height * 0.045,
                                                      width: width * 0.4,
                                                      child: TextContext(
                                                        fontSize: 13,
                                                        data: "Attended",
                                                        color: ColorConstant
                                                            .greenColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                            )
                                          : const Text(''),
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
                                                  height: height * 0.25,
                                                  child: Column(
                                                    children: [
                                                      const TextContext(
                                                          data: "Meeting!",
                                                          fontSize: 14,
                                                          color: Color(0xff000000),
                                                          fontFamily: "poppins_reg",
                                                          fontWeight:
                                                          FontWeight.w500),
                                                      SizedBox(
                                                        height: height * 0.03,
                                                      ),
                                                      TextfieldContext(
                                                        controller: meetingCont,
                                                        enabled: true,
                                                        filled: true,
                                                        fillColor:
                                                        ColorConstant.whiteColor,
                                                        intBorder: true,
                                                        hintText:
                                                        "Enter meeting link.",
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          // const Text("Cancel"),
                                                          InkWell(
                                                              onTap: () {
                                                                Navigator.of(context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5),
                                                                  color: ColorConstant
                                                                      .redColor,
                                                                ),
                                                                alignment:
                                                                Alignment.center,
                                                                height: height * 0.05,
                                                                width: width * 0.25,
                                                                // color: Colors.green,
                                                                child: TextContext(
                                                                    data: "Cancel",
                                                                    fontSize: 12,
                                                                    color: ColorConstant
                                                                        .whiteColor,
                                                                    fontFamily:
                                                                    "poppins_reg",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                              )),
                                                          InkWell(
                                                              onTap: () {
                                                                submit.setSelectedIndex(index);
                                                                if(submit.meetingType==1){
                                                                  submit.meetingApi(
                                                                      appointmentData
                                                                          .userId,
                                                                      appointmentData
                                                                          .id,
                                                                      meetingCont.text,
                                                                      index, context);
                                                                  // setState(() {
                                                                  //   meeting[index] = true;
                                                                  // });

                                                                  meetingCont.clear();
                                                                  Navigator.of(context)
                                                                      .pop();
                                                                }else{

                                                                }

                                                              },
                                                              child: Container(
                                                                decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5),
                                                                  color: ColorConstant
                                                                      .primaryColor,
                                                                ),
                                                                alignment:
                                                                Alignment.center,
                                                                height: height * 0.05,
                                                                width: width * 0.25,
                                                                // color: Colors.green,
                                                                child: TextContext(
                                                                    data: "Submit",
                                                                    fontSize: 12,
                                                                    color: ColorConstant
                                                                        .whiteColor,
                                                                    fontFamily:
                                                                    "poppins_reg",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        child: SizedBox(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant.greenColor),
                                            ),
                                            alignment: Alignment.center,
                                            height: height * 0.045,
                                            width: width * 0.3,
                                            child: TextContext(
                                              fontSize: 13,
                                              data: submit.meetingType == 1
                                                  ? "Meeting"
                                                  : "Start",
                                              color: ColorConstant.greenColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
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

  Widget appointmentInfo(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width / 3,
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
          width: width / 2.5,
          child: TextContext(
              maxLines: 1,
              data: value,
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
          child: documentVerifyViewModel.loadingUpdate &&
                  documentVerifyViewModel.selectedIndexAppointmentId
                          .toString() ==
                      appointmentId
              ? Container(
                  alignment: Alignment.center,
                  height: height * 0.045,
                  width: width * 0.4,
                  child: CircularProgressIndicator(
                    color: ColorConstant.primaryColor,
                  ))
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(width: 1, color: ColorConstant.orangeColor),
                  ),
                  alignment: Alignment.center,
                  height: height * 0.045,
                  width: width * 0.4,
                  child: const TextContext(
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
