import 'dart:math';

import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view/video_call/video_call_screen.dart';
import 'package:doctor_apk/view_model/appointment_view_model.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:doctor_apk/view_model/meeting_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:doctor_apk/view_model/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routes_name.dart';
import 'add_prescription_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int selectIndex = -1;
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
  TextEditingController _timeController = TextEditingController();

  // Method to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Format and set the selected time in the TextField
        _timeController.text = pickedTime.format(context);
      });
    }
  }
  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }
  String generateRoomCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
  @override
  Widget build(BuildContext context) {
    final appointmentViewModel = Provider.of<AppointmentViewModel>(context);
    final submit = Provider.of<MeetingViewModel>(context);
    final documentVerifyViewModel = Provider.of<DocumentVerifyViewModel>(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
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
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, RoutesName.addPrescriptionScreen,arguments: {
                                          "name":appointmentData.name,
                                           "phone":appointmentData.mobile.toString(),
                                           "age":appointmentData.patientAge.toString(),
                                           "gender":appointmentData.patientGender,
                                           "appointmentId":appointmentData.id,
                                           "slotId":appointmentData.slotsId,
                                           "patientId":appointmentData.userId.toString(),

                                    });
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPrescriptionScreen()));
                                  },
                                  child: Image.asset(
                                    "assets/img/add.png",
                                    scale: 4,

                                  ),
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
                                  // appointmentInfo("Phone",
                                  //     appointmentData.mobile.toString()),
                                  appointmentInfo("Patient Age",
                                      appointmentData.patientAge.toString()=="null"?"":appointmentData.patientAge.toString()),
                                  appointmentInfo("Patient Gender",
                                      appointmentData.patientGender.toString()=="null"?"":appointmentData.patientGender.toString()),
                                  appointmentInfo("Requested Date",
                                      DateFormat('EE, dd MMM').format(DateTime.parse(appointmentData.updatedAt))),
                                  appointmentData.date!=null? appointmentInfo("Consult Date",
                                      DateFormat('EE, dd MMM').format(DateTime.parse(appointmentData.date??""))):Container(),
                                  appointmentInfo(
                                    "Payment Mode",
                                    "Online Payment",
                                  ),
                                  appointmentData.appointmentTime!=null?appointmentInfo("Meeting Time", appointmentData.appointmentTime):Container(),
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
                            child:
                            Row(
                              children: [
                             const Text("Description:"),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                SizedBox(
                                  width: width*0.65,
                                  child: TextContext(
                                      data: appointmentViewModel
                                          .currentAppointmentsModel!
                                          .data![index]
                                          .description
                                          .toString(),
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: const Color(0xff979797),
                                      fontFamily: "poppins_reg",
                                      fontWeight: FontWeight.w400),
                                ),

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
                                    .toString()):appointmentViewModel
                        .currentAppointmentsModel!
                        .data![index]
                        .status
                        .toString() ==
                    "1"? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.43,
                                        height: height * 0.045,
                                        child: TextfieldContext(
                                          controller: _timeController,
                                          enabled: true,
                                          onTap:() => _selectTime(context),
                                          filled: true,
                                          fillColor:
                                          ColorConstant.whiteColor,
                                          intBorder: true,
                                          readOnly:true,
                                          hintText:
                                          "Select meeting time ",
                                          hintStyle: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // _selectTime(context);
                                          submit.sendTimeApi( appointmentData.id, _timeController.text,  context);
                                        },
                                        child:
                                        Container(
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
                                            data: "Submit Time",
                                            color: ColorConstant
                                                .greenColor,
                                            fontWeight:
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ):
                            appointmentViewModel
                                .currentAppointmentsModel!
                                .data![index]
                                .status
                                .toString() ==
                                "5"?
                             GestureDetector(
                               onTap: () {
                            final String channel=generateRoomCode(6);
                             Provider.of<TokenViewModel>(context,listen: false).tokenApi(context, channel,appointmentData.slotsId,appointmentData.id,appointmentData.userId,)  ;
                             //     if(appointmentData.meetingStatus=="1"){
                             //       if( formattedDate== appointmentData.date){
                             //         Utils.launchURL(  appointmentViewModel.currentAppointmentsModel!.data![index].meeting);
                             //       }else{
                             //         Utils.show("You can start meeting on ${ DateFormat('EE, dd MMM').format(DateTime.parse(appointmentData.date))}", context);
                             //       }
                             //     }else{
                             //       showDialog(
                             //         context: context,
                             //         barrierDismissible: false,
                             //         builder: (context) => AlertDialog(
                             //             alignment: Alignment.center,
                             //             // backgroundColor: Colors.transparent,
                             //             content: Container(
                             //               padding: const EdgeInsets.all(15),
                             //               height: height * 0.25,
                             //               child: Column(
                             //                 children: [
                             //                   const TextContext(
                             //                       data: "Meeting!",
                             //                       fontSize: 14,
                             //                       color: Color(0xff000000),
                             //                       fontFamily: "poppins_reg",
                             //                       fontWeight:
                             //                       FontWeight.w500),
                             //                   SizedBox(
                             //                     height: height * 0.03,
                             //                   ),
                             //                   TextfieldContext(
                             //                     controller: meetingCont,
                             //                     enabled: true,
                             //                     filled: true,
                             //                     fillColor:
                             //                     ColorConstant.whiteColor,
                             //                     intBorder: true,
                             //                     hintText:
                             //                     "Enter meeting link.",
                             //                   ),
                             //                   const Spacer(),
                             //                   Row(
                             //                     mainAxisAlignment:
                             //                     MainAxisAlignment
                             //                         .spaceBetween,
                             //                     children: [
                             //                       InkWell(
                             //                           onTap: () {
                             //                             Navigator.of(context)
                             //                                 .pop();
                             //                           },
                             //                           child: Container(
                             //                             decoration:
                             //                             BoxDecoration(
                             //                               borderRadius:
                             //                               BorderRadius
                             //                                   .circular(
                             //                                   5),
                             //                               color: ColorConstant
                             //                                   .redColor,
                             //                             ),
                             //                             alignment:
                             //                             Alignment.center,
                             //                             height: height * 0.05,
                             //                             width: width * 0.25,
                             //                             // color: Colors.green,
                             //                             child: TextContext(
                             //                                 data: "Cancel",
                             //                                 fontSize: 12,
                             //                                 color: ColorConstant
                             //                                     .whiteColor,
                             //                                 fontFamily:
                             //                                 "poppins_reg",
                             //                                 fontWeight:
                             //                                 FontWeight
                             //                                     .w600),
                             //                           )),
                             //                       InkWell(
                             //                           onTap: () {
                             //                               submit.meetingApi(appointmentData.userId, appointmentData.id, meetingCont.text,  context);
                             //                               Navigator.of(context)
                             //                                   .pop();
                             //
                             //                           },
                             //                           child: Container(
                             //                             decoration:
                             //                             BoxDecoration(
                             //                               borderRadius:
                             //                               BorderRadius
                             //                                   .circular(
                             //                                   5),
                             //                               color: ColorConstant
                             //                                   .primaryColor,
                             //                             ),
                             //                             alignment:
                             //                             Alignment.center,
                             //                             height: height * 0.05,
                             //                             width: width * 0.25,
                             //                             // color: Colors.green,
                             //                             child: TextContext(
                             //                                 data: "Submit",
                             //                                 fontSize: 12,
                             //                                 color: ColorConstant
                             //                                     .whiteColor,
                             //                                 fontFamily:
                             //                                 "poppins_reg",
                             //                                 fontWeight:
                             //                                 FontWeight
                             //                                     .w600),
                             //                           ))
                             //                     ],
                             //                   )
                             //                 ],
                             //               ),
                             //             )),
                             //       );
                             //     }
                             //     submit.savedIndices.contains(index);

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
                                     data: appointmentData.meetingStatus=="1"
                                         ? "Start"
                                         : "Meeting",
                                     color: ColorConstant.greenColor,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                               ),
                             )
                                :appointmentViewModel
                        .currentAppointmentsModel!
                        .data![index]
                        .status
                        .toString() ==
                    "2"?GestureDetector(
                              onTap: () {
                                final String channel=generateRoomCode(6);
                                Provider.of<TokenViewModel>(context,listen: false).tokenApi(context, channel,appointmentData.slotsId,appointmentData.id,appointmentData.userId,)  ;

                                // Utils.launchURL(  appointmentViewModel.currentAppointmentsModel!.data![index].meeting);
                                // documentVerifyViewModel
                                //     .statusUpdateApi(appointmentViewModel.currentAppointmentsModel!.data![index].id.toString(),
                                //     "6",
                                //     context);
                              },
                              child:
                              Container(
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
                                  data: "Start Meeting",
                                  color: ColorConstant
                                      .greenColor,
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),
                            ):
                    GestureDetector(
                              onTap: () {
                                documentVerifyViewModel
                                    .statusUpdateApi(appointmentViewModel.currentAppointmentsModel!.data![index].id.toString(),
                                    "4",
                                    context);
                              },
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(5),
                                  border: Border.all(
                                      width: 1,
                                      color: ColorConstant
                                          .redColor),
                                ),
                                alignment:
                                Alignment.center,
                                height: height * 0.045,
                                width: width * 0.4,
                                child: TextContext(
                                  fontSize: 13,
                                  data: "End",
                                  color: ColorConstant
                                      .redColor,
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),
                            )
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
