import 'package:doctor_apk/generated/assets.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/view_model/splash_service.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imgHealth),
              fit: BoxFit.contain,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextContext(
                data: "Your health's true",
                fontSize: AppConstant.fontSizeLarge,
                color: ColorConstant.blueColor,
                fontWeight: FontWeight.bold,
              ),
              TextContext(
                data: "Companion",
                fontSize: AppConstant.fontSizeLarge,
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
