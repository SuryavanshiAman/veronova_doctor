import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view/auth/sign_up.dart';
import 'package:doctor_apk/view/home/home_screen.dart';
import 'package:doctor_apk/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/text_context.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController mobileCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      bottomSheet: Container(
        height: height * 0.76,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: ColorConstant.whiteColor),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            const TextContext(
              data: "Phone Number",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff444343),
              fontFamily: "poppins_reg",
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextfieldContext(
            maxLength: 10,
              controller: mobileCon,
              enabled: true,
              filled: true,
              fillColor: ColorConstant.whiteColor,
              intBorder: false,
              hintText: "Enter valid phone number",
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: height * 0.050,
            ),
            SizedBox(
              width: width,
              height: height * 0.055,
              child: GestureDetector(
                onTap: () {
                  if(mobileCon.text.length ==10 ){
                    authViewModel.loginApi(mobileCon.text, context);
                  }else {
                    Utils.show(' Please Enter 10 digit Number', context);
                  }
                },
                child: ButtonConst(
                  loading: authViewModel.loading,
                  alignment: Alignment.center,
                  width: width,
                  height: height * 0.055,
                  color: ColorConstant.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  label: 'Get Otp',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: height / 55,
            ),
            Row(
              children: [
                const TextContext(
                  data: "Don’t have an account? ",
                  color: Color(0xffBBB7B7),
                  fontWeight: FontWeight.w400,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: TextContext(
                      data: "SignUp",
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: ColorConstant.whiteColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.020,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  const HomeScreen()));
                },
                child: TextContext(
                  data: 'Login',
                  fontSize: 25,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: "poppins_reg",
                )),
            TextContext(
              data: "Hello again, you’ve been missed",
              color: ColorConstant.whiteColor,
              fontWeight: FontWeight.w500,
              fontFamily: "poppins_reg",
            ),
            SizedBox(
              height: height * 0.020,
            ),
          ],
        ),
      ),
    );
  }
}
