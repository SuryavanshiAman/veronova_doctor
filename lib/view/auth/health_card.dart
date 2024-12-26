import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/view/auth/sign_up.dart';
import 'package:flutter/material.dart';

import '../../res/text_context.dart';

class Healthcard extends StatefulWidget {
  const Healthcard({super.key});

  @override
  State<Healthcard> createState() => _HealthcardState();
}

class _HealthcardState extends State<Healthcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // bottomSheet: ,
        backgroundColor: ColorConstant.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.040,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              width: width * 0.4,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 0.8,
                        offset: Offset(0, 2)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
              child: Column(
                children: [
                  FittedBox(
                    child: RichText(
                        text:  TextSpan(children: [
                      TextSpan(
                          text: "Veronova",
                          style: TextStyle(
                            fontFamily: "prosto_one_regular",
                              color: Color(0xff066ac7),
                              fontWeight: FontWeight.w600,
                              fontSize: height*0.02)),
                      TextSpan(
                          text: "Doctor",
                          style: TextStyle(
                              color: Color(0xff13c7eb),
                              fontWeight: FontWeight.w600,
                              fontFamily: "prosto_one_regular",
                              fontSize: height*0.02))
                    ])),
                  ),
                  FittedBox(
                    child: TextContext(
                      data: "For Doctors",
                      color: ColorConstant.greyColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: "prosto_one_regular",
                      fontSize: height*0.02,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: height * 0.075,
            ),
            Center(
              child: SizedBox(
                width: width,
                height: height * 0.3,
                child: Image.asset('assets/img/doctor_2.png'),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: ColorConstant.primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.030,
                      ),
                      TextContext(
                        data: "Let’s Get Started",
                        fontSize: 25,
                        color: ColorConstant.whiteColor,
                        fontFamily: "poppins_reg",
                        fontWeight: FontWeight.w600,
                      ),
                      AppConstant.spaceHeight10,
                      TextContext(
                        data:
                            "To get started, simply create an account or login if you already have an account.",
                        maxLines: 2,
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: "poppins_reg",
                      ),
                      AppConstant.spaceHeight20,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(55, (index) {
                            return const TextContext(
                              data: "-",
                              fontSize: 6,
                              color: ColorConstant.lightGrayColor,
                            );
                          })),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      TextContext(
                        data: "Login",
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "poppins_reg",
                      ),
                      AppConstant.spaceHeight5,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.login);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          width: width,
                          decoration: BoxDecoration(
                              color: ColorConstant.whiteColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextContext(
                                data: "Login",
                                fontSize: 17,
                                color: ColorConstant.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              Icon(
                                Icons.arrow_circle_right,
                                color: ColorConstant.primaryColor,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      TextContext(
                        data: "Signup",
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "poppins_reg",
                      ),
                      AppConstant.spaceHeight5,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          width: width,
                          decoration: BoxDecoration(
                              color: ColorConstant.whiteColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextContext(
                                data: "Signup",
                                fontSize: 17,
                                color: ColorConstant.primaryColor,
                                fontFamily: "poppins_reg",
                                fontWeight: FontWeight.w600,
                              ),
                              Icon(
                                Icons.arrow_circle_right,
                                color: ColorConstant.primaryColor,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.020,
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
