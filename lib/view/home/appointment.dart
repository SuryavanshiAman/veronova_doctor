import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/view/document.dart';
import 'package:doctor_apk/view/home/home_screen.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHealthCard extends StatefulWidget {
  const HomeHealthCard({super.key});

  @override
  State<HomeHealthCard> createState() => _HomeHealthCardState();
}

class _HomeHealthCardState extends State<HomeHealthCard> {
  bool count = false;
  bool countIndex = true;

  @override
  void initState() {
    super.initState();
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileApi(context);
    Provider.of<ProfileViewModel>(context, listen: false).doctorCatApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).modelData?.data;
    return profileViewModel != null
        ? Center(
            child: CircularProgressIndicator(
            // color: ColorConstant.primaryColor,
            color: Colors.red,
          ))
        // :
    // profileViewModel.status.toString() == "400"
    //         ? const TextContext(data: "Opps! no data found")
            : Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorConstant.homeGaryColor,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "assets/icon/green-Dot.gif",
                            color: profileViewModel?.status.toString() == "0"
                                ? ColorConstant.redColor
                                : ColorConstant.greenColor,
                          )),
                    )
                  ],
                  backgroundColor: ColorConstant.lightGrayColor,
                  title: const TextContext(
                    data: "Appointments",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1E1E1E),
                  ),
                ),
                body: profileViewModel?.document.toString() == "0"
                    ? verifyDocs()
                    : profileViewModel?.document.toString() == "1"
                        ? underProcess()
                        // : profileViewModel?.document.toString() == "2"
                        : profileViewModel?.document.toString() != "2"
                            ?  const HomeScreen()
                            : const Text('No Data Found'),
              );
  }

  Widget verifyDocs() {
    return Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: height * 0.068),
        child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffF0FCFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: ColorConstant.primaryColor),
            ),
            width: width * 0.9,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: height * 0.04),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextContext(
                          data: "Pending Profile",
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppins_reg",
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const TextContext(
                        fontWeight: FontWeight.w400,
                        data:
                            "Your document details are missing. Please upload all the valid documents in order to continue using the app.",
                        color: Color(0xff444343),
                        fontFamily: "poppins_reg",
                        fontSize: 12,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.reqDocsVerification);
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextContext(
                            data: "Upload Document",
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "poppins_reg",
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )),
            ])));
  }

  Widget underProcess() {
    return Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: height * 0.068),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: ColorConstant.redColor),
              color: ColorConstant.whiteColor,
            ),
            width: width * 0.9,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: height * 0.05),
                  child: const Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextContext(
                          data: "Verification Under process!",
                          color: ColorConstant.redColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppins_reg",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextContext(
                        fontWeight: FontWeight.w400,
                        data:
                            "Please wait, your uploaded documents are under verification. Once verification is completed, you can access your profile.",
                        color: Color(0xff444343),
                        fontFamily: "poppins_reg",
                        fontSize: 12,
                      ),
                    ],
                  )),
            ])));
  }
}
