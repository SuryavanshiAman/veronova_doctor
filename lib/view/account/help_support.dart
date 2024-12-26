import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/text_context.dart';

import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/help_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  final TextEditingController mobileCon = TextEditingController();
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController messageCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final helpViewModel = Provider.of<HelpViewModel>(context);
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
              color: Color(0xff1E1E1E),
            )),
        centerTitle: true,
        title: TextContext(
          data: "Support",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          shrinkWrap: true,
          children: [
            AppConstant.spaceHeight15,
            const TextContext(
              data: "HOW MAY WE\nHELP YOU?",
              fontSize: 25,
              maxLines: 2,
              fontWeight: FontWeight.w600,
                color:  Color(0xff353535),
                fontFamily: "poppins_reg"
            ),
            AppConstant.spaceHeight15,
            TextContext(
              data: "Request a call",
              fontSize: 15,

                fontWeight: FontWeight.w500,

                color: ColorConstant.primaryColor,
                fontFamily: "poppins_reg"
            ),
            AppConstant.spaceHeight20,
            TextfieldContext(
              controller: nameCon,
              enabled: true,
              intBorder: false,
              prefixIcon: Icon(
                Icons.person_rounded,
                color: ColorConstant.primaryColor,
              ),
              hintText: "Your name",
              keyboardType: TextInputType.streetAddress,
              filled: true,
              fillColor: ColorConstant.whiteColor,
            ),
            AppConstant.spaceHeight10,
            TextfieldContext(
              controller: mobileCon,
              maxLength: 10,
              keyboardType: TextInputType.number,
              enabled: true,
              filled: true,
              fillColor: ColorConstant.whiteColor,
              intBorder: false,
              hintText: "Phone No.",
              prefixIcon: Icon(
                Icons.call,
                color: ColorConstant.primaryColor,
              ),
            ),
            AppConstant.spaceHeight15,
            SizedBox(
              width: width * 0.83,
              height: height * 0.12,
              child: TextfieldContext(
                  controller: messageCon,
                  prefixIcon: Icon(
                    Icons.edit,
                    color: ColorConstant.primaryColor,
                  ),
                  maxLines: 5,
                  hintText: "Write your message",
                  intBorder: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  filled: true,
                  fillColor: ColorConstant.whiteColor,
                  enabled: true),
            ),
            AppConstant.spaceHeight20,
            ButtonConst(
                onTap: () {
                  if (nameCon.text.isEmpty  ) {
                    Utils.show("Please enter your name", context);
                  } else if (mobileCon.text.isEmpty && mobileCon.text.length !=10) {
                    Utils.show("Please enter your phone No.", context);
                  } else if (messageCon.text.isEmpty) {
                    Utils.show("Please enter your Message", context);
                  } else {
                    helpViewModel.helpApi(
                        nameCon.text, mobileCon.text, messageCon.text, context);
                  }
                },
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(5),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                color: ColorConstant.primaryColor,
                label: "Submit",
                fontSize: 18,
              fontWeight: FontWeight.w600,
                ),
            AppConstant.spaceHeight50,
            Container(
              height: height * 0.30,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/help.png'))),
            ),
          ],
        ),
      ),
    );
  }
}
