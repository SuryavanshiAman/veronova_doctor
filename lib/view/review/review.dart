import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  int? countIndex;

  @override
  void initState() {
    super.initState();
    final doctorViewModel =
        Provider.of<DoctorViewModel>(context, listen: false);
    doctorViewModel.doctorVRApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final doctorViewModel = Provider.of<DoctorViewModel>(context);

    return Scaffold(
      backgroundColor: ColorConstant.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.lightGrayColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: const Color(0xff1E1E1E),
            )),
      ),
      body: doctorViewModel.doctorVRModel == null
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.primaryColor,
            ))
          : doctorViewModel.doctorVRModel!.status == 400
              ? const Center(child: TextContext(data: "Data not found"))
              : ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: width,
                      height: height * 0.25,
                      color: ColorConstant.lightGrayColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: width,
                            child: Image.asset(
                              "assets/img/trangale.png",
                              scale: 5,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: height * 0.15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextContext(
                                        data: doctorViewModel
                                                .doctorVRModel!.data!.name ??
                                            "Dr Name".toString(),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff1E1E1E),
                                        fontFamily: "poppins_reg"),
                                    TextContext(
                                        data: doctorViewModel.doctorVRModel!
                                                .data!.department
                                                ?.toString() ??
                                            'Not added',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff7C7979),
                                        fontFamily: "poppins_reg"),
                                    TextContext(
                                        data: doctorViewModel.doctorVRModel!
                                                .data!.qualification
                                                ?.toString() ??
                                            'qualification',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff7C7979),
                                        fontFamily: "poppins_reg"),
                                    TextContext(
                                        textAlign: TextAlign.start,
                                        data:
                                            "${doctorViewModel.doctorVRModel!.data!.exp == null ? '0' : doctorViewModel.doctorVRModel!.data!.exp.toString()} years experience",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff1E1E1E),
                                        fontFamily: "poppins_reg")
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.106,
                                width: height * 0.106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  border: Border.all(
                                      width: 0.5,
                                      color: ColorConstant.greyColor),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    doctorViewModel.doctorVRModel!.data!.profile
                                        .toString(),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: height * 0.6,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: height * 0.010),
                              color: ColorConstant.whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icon/home.png",
                                        scale: 4.8,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const TextContext(
                                          data: " Clinic address",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff7C7979),
                                          fontFamily: "poppins_reg")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextContext(
                                      data: doctorViewModel.doctorVRModel!.data!
                                                  .address ==
                                              null
                                          ? "Not added"
                                          : doctorViewModel
                                              .doctorVRModel!.data!.address
                                              .toString(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff000000),
                                      fontFamily: "poppins_reg"),
                                  SizedBox(
                                    height: height * 0.020,
                                  ),
                                  const TextContext(
                                      data: "Appointment Fee",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1E1E1E),
                                      fontFamily: "poppins_reg"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextContext(
                                      data:
                                          "₹ ${doctorViewModel.doctorVRModel!.data!.fees == null ? '500' : doctorViewModel.doctorVRModel!.data!.fees.toString()}")
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.010,
                            ),
                            Container(
                              height: height * 0.3,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              color: ColorConstant.whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const TextContext(
                                      data: "Highly Recommended for",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      fontFamily: "poppins_reg"),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: height * 0.165,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.asset(
                                                "assets/icon/heart.png",
                                                scale: 5,
                                              ),
                                              Image.asset(
                                                "assets/icon/msg.png",
                                                scale: 5,
                                              ),
                                            ],
                                          )),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const TextContext(
                                                data: "Doctor Friendliness",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff1E1E1E),
                                                fontFamily: "poppins_reg"),
                                            SizedBox(
                                              width: width * 0.82,
                                              child: const TextContext(
                                                  data:
                                                      "Your comfort and well-being are our top priority at every step of your care.",
                                                  maxLines: 3,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff444343),
                                                  fontFamily: "poppins_reg"),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const TextContext(
                                                data:
                                                    "Detailed Treatment Explanation",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff1E1E1E),
                                                fontFamily: "poppins_reg"),
                                            SizedBox(
                                              width: width * 0.015,
                                            ),
                                            SizedBox(
                                              width: width * 0.82,
                                              child: const TextContext(
                                                  data:
                                                      "Provides an in-depth analysis of the patient’s condition outlining the recommended treatment plan, potential risks, and expected outcomes.",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff444343),
                                                  fontFamily: "poppins_reg"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.010,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: height * 0.010),
                              decoration: BoxDecoration(
                                color: ColorConstant.whiteColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: doctorViewModel
                                      .doctorVRModel!.doctorReview!.isEmpty
                                  ? const Center(
                                      child: Text(
                                      'Patient has not given any review',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff1E1E1E),
                                          fontFamily: "poppins_reg"),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: doctorViewModel
                                          .doctorVRModel!.doctorReview!.length,
                                      itemBuilder: (context, index) {
                                        return doctorViewModel.doctorVRModel!
                                                .doctorReview!.isEmpty
                                            ? const Text(
                                                'No Review Found',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            : index == 0
                                                ? Row(
                                                    children: List.generate(5,
                                                        (index) {
                                                      return index == 0
                                                          ? const TextContext(
                                                              data:
                                                                  'Patient Review',
                                                              fontSize: 16,
                                                            )
                                                          : Icon(
                                                              Icons.star,
                                                              color: ColorConstant
                                                                  .addressColor,
                                                            );
                                                    }),
                                                  )
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              height * 0.010,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width:
                                                                  height * 0.07,
                                                              height:
                                                                  height * 0.07,
                                                              decoration: BoxDecoration(
                                                                  color: ColorConstant
                                                                      .cAvtColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40)),
                                                              child:
                                                                  TextContext(
                                                                data: doctorViewModel
                                                                    .doctorVRModel!
                                                                    .doctorReview![
                                                                        index]
                                                                    .userName
                                                                    .toString()
                                                                    .substring(
                                                                        0, 1)
                                                                    .toUpperCase(),
                                                                fontSize: 25,
                                                                color: ColorConstant
                                                                    .whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.020,
                                                            ),
                                                            TextContext(
                                                                data: doctorViewModel
                                                                    .doctorVRModel!
                                                                    .doctorReview![
                                                                        index]
                                                                    .userName
                                                                    .toString())
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.010,
                                                        ),
                                                        TextContext(
                                                          data: doctorViewModel
                                                              .doctorVRModel!
                                                              .doctorReview![
                                                                  index]
                                                              .message
                                                              .toString(),
                                                          maxLines: 4,
                                                          fontSize: 12,
                                                          color: ColorConstant
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.020,
                                                        ),
                                                        countIndex == countIndex
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: List
                                                                    .generate(
                                                                        60,
                                                                        (context) {
                                                                  return TextContext(
                                                                    data: "-",
                                                                    fontSize: 5,
                                                                    color: ColorConstant
                                                                        .greyColor,
                                                                  );
                                                                }),
                                                              )
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: List
                                                                    .generate(
                                                                        40,
                                                                        (context) {
                                                                  return const Text(
                                                                      "");
                                                                }),
                                                              ),
                                                      ],
                                                    ),
                                                  );
                                      }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

class ReviewModel {
  final String title;
  final String subTile;
  ReviewModel({required this.title, required this.subTile});
}
