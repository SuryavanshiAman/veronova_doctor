import 'package:doctor_apk/generated/assets.dart';
import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';

import 'package:doctor_apk/res/common_filter_popup.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../res/make_call.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int selectIndex = -1;
  int selectBorder = -1;

  @override
  void initState() {
    super.initState();
  Provider.of<DoctorViewModel>(context, listen: false).doctorHistoryApi(5, 0, context);
  }

  @override
  Widget build(BuildContext context) {
    final doctorViewModel = Provider.of<DoctorViewModel>(context);

    return Scaffold(
      backgroundColor: ColorConstant.scaffoldBgColor,
      appBar: AppBar(
        leadingWidth: width,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icon/arrow_1.png",
                    scale: 6,
                    color: const Color(0xff1E1E1E),
                  )),
              const SizedBox(
                width: 15,
              ),
              const TextContext(
                data: "History",
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xff1E1E1E),
              ),
            ],
          ),
        ),
        backgroundColor: ColorConstant.whiteColor,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const CommonFilterPopup(
                      title: 'Filter by status',
                    );
                  });
            },
            child: Icon(
              Icons.filter_alt,
              color: ColorConstant.cAvtColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const CommonFilterPopup(
                      title: 'Filter by status',
                    );
                  });
            },
            child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 18, 0),
                child: Text(
                  "Filter",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1E1E1E),
                    fontFamily: "poppins_reg",
                  ),
                )),
          )
        ],
      ),
      body: doctorViewModel.doctorHistoryModel == null
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.primaryColor,
            ))
          : doctorViewModel.doctorHistoryModel!.status == "400"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 25),
                      child: TextContext(
                        data: "Nothing is here.",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1E1E1E),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: TextContext(
                        data: "Accept your first appointment now !",
                        fontWeight: FontWeight.w400,
                        color: Color(0xff444343),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                        child: Image.asset(
                      Assets.imgAppointmentBlank,
                      scale: 4,
                    )),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<DoctorViewModel>(context, listen: false)
                        .doctorHistoryApi(5, 0, context);
                  },
                  child: ListView.builder(
                    padding:const EdgeInsets.only(bottom: 15) ,
                      shrinkWrap: true,
                      itemCount: doctorViewModel
                          .doctorHistoryModel!.data!.length,
                      itemBuilder: (context, index) {
                      final data =doctorViewModel
                          .doctorHistoryModel!.data![index];
                        return Container(
                            margin: EdgeInsets.fromLTRB(
                                0, height * 0.015, 0, index == 4 ? 10 : 0),
                            color: ColorConstant.whiteColor,
                            width: width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.030,
                                  vertical: height * 0.010),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                            text: "Appointment ID : ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "poppins_reg",
                                              color: Color(0xff1E1E1E),
                                            )),
                                        TextSpan(
                                            text: data
                                                .id
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "poppins_reg",
                                              color: Color(0xff1E1E1E),
                                            ))
                                      ])),
                                      Image.asset(
                                        "assets/img/trangale.png",
                                        scale: 4,
                                      )
                                    ],
                                  ),
                                  AppConstant.spaceHeight5,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(80, (context) {
                                      return TextContext(
                                        data: "-",
                                        color: ColorConstant.greyColor,
                                        fontSize: 5,
                                        fontWeight: FontWeight.w100,
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.020),
                                        width: width * 0.2,
                                        child: Image.asset(
                                          Assets.imgDoctor2,
                                          scale: 3,
                                        ),
                                      ),
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextContext(
                                            maxLines: 1,
                                            data: "Name",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "poppins_reg",
                                            color: Color(0xff1E1E1E),
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data: "Phone",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "poppins_reg",
                                            color: Color(0xff1E1E1E),
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data: "Patient Age",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "poppins_reg",
                                            color: Color(0xff1E1E1E),
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data: "Requested Time",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "poppins_reg",
                                            color: Color(0xff1E1E1E),
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data: "Payment Mode",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "poppins_reg",
                                            color: Color(0xff1E1E1E),
                                          )
                                        ],
                                      ),
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextContext(
                                            data: ": ",
                                          ),
                                          TextContext(data: ": "),
                                          TextContext(data: ": "),
                                          TextContext(data: ": "),
                                          TextContext(data: ": "),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextContext(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            data: data
                                                .name
                                                .toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "poppins_reg",
                                            color: const Color(0xff444343),
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data: data
                                                .mobile
                                                .toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "poppins_reg",
                                            color: const Color(0xff444343),
                                          ),
                                          Row(
                                            children: [
                                              TextContext(
                                                data: data
                                                    .patientAge
                                                    .toString(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "poppins_reg",
                                                color: const Color(0xff444343),
                                              ),
                                              const TextContext(
                                                data: " Years",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "poppins_reg",
                                                color: Color(0xff444343),
                                              )
                                            ],
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data:
                                                "${DateFormat('EE, dd MMM').format(DateTime.parse(data.updatedAt.toString()))},",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "poppins_reg",
                                            color: const Color(0xff444343),
                                          ),
                                          TextContext(
                                            maxLines: 1,
                                            data:"Offline",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "poppins_reg",
                                            color: const Color(0xff444343),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(80, (context) {
                                      return TextContext(
                                        data: "-",
                                        color: ColorConstant.greyColor,
                                        fontSize: 5,
                                        fontWeight: FontWeight.w100,
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Image.asset(
                                  //       "assets/icon/map.png",
                                  //       scale: 5,
                                  //     ),
                                  //     SizedBox(
                                  //       width: width * 0.02,
                                  //     ),
                                  //     TextContext(
                                  //       data: doctorViewModel
                                  //           .doctorHistoryModel!
                                  //           .doctorHistoryData![index]
                                  //           .address
                                  //           .toString(),
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.w400,
                                  //       fontFamily: "poppins_reg",
                                  //       color: const Color(0xff979797),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: const TextContext(
                                            data: ".",
                                            fontSize: 18,
                                            textAlign: TextAlign.center,
                                          )),
                                      const TextContext(
                                        data: " ₹ ",
                                      ),
                                      TextContext(
                                        data: data
                                            .doctorFees
                                            .toString(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "poppins_reg",
                                        color: const Color(0xff000000),
                                      ),
                                      const TextContext(
                                        data: " Consultation Fees",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "poppins_reg",
                                        color: Color(0xff000000),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Container(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 10),
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(5),
                                        //     border: selectIndex == index
                                        //         ? Border.all(
                                        //             width: 1,
                                        //             color: ColorConstant.greenColor)
                                        //         : Border.all(
                                        //             width: 1,
                                        //             color: ColorConstant.redColor),
                                        //   ),
                                        //   alignment: Alignment.center,
                                        //   height: height * 0.045,
                                        //   width: width * 0.4,
                                        //   child: TextContext(
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w500,
                                        //     data: doctorViewModel
                                        //                 .doctorHistoryModel!
                                        //                 .doctorHistoryData![index]
                                        //                 .status ==
                                        //             2
                                        //         ? "Consultancy Done"
                                        //         : "Rejected",
                                        //     color: doctorViewModel
                                        //                 .doctorHistoryModel!
                                        //                 .doctorHistoryData![index]
                                        //                 .status ==
                                        //             1
                                        //         ? ColorConstant.greenColor
                                        //         : ColorConstant.redColor,
                                        //   ),
                                        // ),
                                        statusButton(
                                            status: int.parse(data.status.toString())),
                                        InkWell(
                                          onTap: () {
                                            MakeCall.openDialPad(data
                                                .mobile
                                                .toString());
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              alignment: Alignment.center,
                                              width: width * 0.4,
                                              height: height * 0.045,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    color: ColorConstant
                                                        .whiteColor,
                                                    "assets/icon/reqDail.png",
                                                    scale: 6.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  TextContext(
                                                    fontSize: 12,
                                                    data: "Contact",
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorConstant
                                                        .whiteColor,
                                                  )
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }),
                ),
    );
  }

  Widget statusButton({
    required int status,
  }) {
    Color contentColor =
        status == 2 ? ColorConstant.greenColor :status == 1 ?ColorConstant.orangeColor: ColorConstant.redColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: contentColor,
        ),
      ),
      alignment: Alignment.center,
      height: height * 0.045,
      width: width * 0.4,
      child: TextContext(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        data: status == 2
            ? "Consultancy Done"
            : status == 3
                ? "Rejected"
                : status == 4
                    ? "Canceled"
                    : "Accept",
        color: contentColor,
      ),
    );
  }
}

class PopupContainer extends StatelessWidget {
  final double? containerHeight;
  final double? containerWidth;
  final String tittle;
  final VoidCallback? onTap;

  const PopupContainer(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      required this.tittle,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstant.greyColor),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            tittle,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstant.greyColor),
          )),
    );
  }
}
