import 'dart:async';

import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view/bottombar/bottom_bar.dart';
import 'package:doctor_apk/view_model/auth_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class FillTheOtp extends StatefulWidget {
  const FillTheOtp({super.key});

  @override
  State<FillTheOtp> createState() => _FillTheOtpState();
}

class _FillTheOtpState extends State<FillTheOtp> {
  final TextEditingController otpCon = TextEditingController();
  @override
  void initState() {
    super.initState();
    startTimer();
    Future.delayed(Duration.zero, () {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (arguments != null) {
        final authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        authViewModel.sendOtpApi(arguments['phone'], context);
      } else {
        if (kDebugMode) {
          print('No arguments found');
        }
      }
    });
  }

  Timer? _timer;
  int _start = 30;
  bool _isButtonVisible = true;

  void startTimer() {
    setState(() {
      _isButtonVisible = false;
      _start = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start == 0) {
          _isButtonVisible = true;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    Map arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.025,
          ),
          Container(
              width: width,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
              ),
              child: TextContext(
                data: 'Fill the OTP',
                fontSize: 22,
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.w600,
                fontFamily: "poppins_reg",
              )),
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: TextContext(
                data: "Verify your account using OTP",
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: "poppins_reg",
              )),
          const Spacer(),
          Container(
              height: height * 0.75,
              width: width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: ColorConstant.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.040,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextContext(
                      data: "OTP",
                      color: Color(0xff444343),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins_reg",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: width,
                      height: height * 0.065,
                      child: Pinput(
                        controller: otpCon,
                        autofocus: true,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        length: 5,
                        defaultPinTheme: PinTheme(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            //   padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: const Color(0xff7C7979)))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  if (!_isButtonVisible)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "Resend OTP in $_start seconds",
                        style: const TextStyle(
                          color: Color(0xff1E1E1E),
                        ),
                      ),
                    ),
                  if (_isButtonVisible)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: GestureDetector(
                        onTap: () {
                          startTimer();
                          final authViewModel = Provider.of<AuthViewModel>(
                              context,
                              listen: false);
                          authViewModel.sendOtpApi(arguments['phone'], context);
                        },
                        child: TextContext(
                          data: "Resend OTP",
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "poppins_reg",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GestureDetector(
                      onTap: () {
                        if (otpCon.length == 5 && otpCon.text=="11111") {
                          Navigator.pushNamed(context, RoutesName.bottomPage);
                          // authViewModel.verifyOtpApi(
                          //     arguments['phone'], otpCon.text, context);
                        }
                        else {
                          Utils.show("Please enter Valid Otp", context);
                        }
                      },
                      child: ButtonConst(
                        loading: authViewModel.sendOtp,
                        alignment: Alignment.center,
                        height: height * 0.055,
                        width: width,
                        color: ColorConstant.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        label: arguments['status'] == 0 ? "Login" : "Signup",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        const TextContext(
                          data: "By continuing, you agree to our",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff1E1E1E),
                          fontFamily: "poppins_reg",
                        ),
                        TextContext(
                          data: " Terms & Conditions",
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "poppins_reg",
                          fontSize: 12,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
