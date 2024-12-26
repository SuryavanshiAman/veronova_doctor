import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/common_delete_popup.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/view/account/account.dart';
import 'package:doctor_apk/view/history/history.dart';
import 'package:doctor_apk/view/home/appointment.dart';
import 'package:doctor_apk/view/review/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HealthCradButton extends StatefulWidget {
  final int initialIndex;
  const HealthCradButton({super.key,this.initialIndex=0});

  @override
  State<HealthCradButton> createState() => _HealthCradButtonState();
}

class _HealthCradButtonState extends State<HealthCradButton> {
  int itemCount = 0;
  final screenList = [
    const HomeHealthCard(),
    const History(),
    // const Review(),
    const Account(),
  ];

  @override
  void initState() {
    itemCount= widget.initialIndex;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (v) async {
        await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonDeletePopup(
            title: 'Are you sure you want to exit the application ?',
            yes: () {
              SystemNavigator.pop();
            },
          );
        },
        );
      },
      child: Scaffold(
        body: screenList[itemCount],
        bottomNavigationBar: bottomBar(context),
      ),
    );
  }

  Widget bottomBar(context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: ColorConstant.greyColor, blurRadius: 5, spreadRadius: 0.5)
        ],
        color: ColorConstant.whiteColor,
      ),

      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                itemCount = 0;
              });
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/icon/appoint.png",
                  scale: 5,
                  color: itemCount == 0
                      ? ColorConstant.primaryColor
                      : const Color(0xff979797),
                ),
                const SizedBox(height: 3,),
                TextContext(
                  data: "Appointments",
                  color: itemCount == 0
                      ? ColorConstant.primaryColor
                      : const Color(0xff979797),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                itemCount = 1;
              });
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/icon/history.png",
                  scale: 5,
                  color: itemCount == 1
                      ? ColorConstant.primaryColor
                      : const Color(0xff979797),
                ),
                const SizedBox(height: 3,),
                TextContext(
                  data: "History",
                  color: itemCount == 1
                      ? ColorConstant.primaryColor
                      : const Color(0xff979797),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                )
              ],
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       itemCount = 2;
          //     });
          //   },
          //   child: Column(
          //     children: [
          //       Image.asset(
          //         "assets/icon/review.png",
          //         scale: 5,
          //         color: itemCount == 2
          //             ? ColorConstant.primaryColor
          //             : const Color(0xff979797),
          //       ),
          //       const SizedBox(height: 3,),
          //       TextContext(
          //         data: "Review",
          //         color: itemCount == 2
          //             ? ColorConstant.primaryColor
          //             : const Color(0xff979797),
          //         fontWeight: FontWeight.w500,
          //         fontSize: 12,
          //       ),
          //     ],
          //   ),
          // ),
          InkWell(
            onTap: () {
              setState(() {
                itemCount = 2;
              });
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/icon/account.png",
                  scale: 5,
                  color: itemCount == 2
                      ? ColorConstant.primaryColor
                      : const Color(0xff979797),
                ),
                const SizedBox(height: 3,),
                TextContext(
                  data: "Account",
                  color: itemCount == 2
                      ? ColorConstant.primaryColor
                      : const Color(0xff979797),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class NavigatorService {
  static void navigateToScreenOne(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  const HealthCradButton(initialIndex: 0)),
        );
  }
}