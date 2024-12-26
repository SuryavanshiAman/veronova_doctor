import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/view/account/document.dart';
import 'package:doctor_apk/view/auth/fill_the_otp.dart';
import 'package:doctor_apk/view/auth/health_card.dart';
import 'package:doctor_apk/view/auth/login_page.dart';
import 'package:doctor_apk/view/auth/sign_up.dart';
import 'package:doctor_apk/view/bottombar/bottom_bar.dart';
import 'package:doctor_apk/view/document.dart';
import 'package:doctor_apk/view/no_internet.dart';
import 'package:doctor_apk/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
        case RoutesName.splashScreen:
        return (context) => const SplashScreen();
        case RoutesName.mainScreen:
        return (context) => const Healthcard();
        case RoutesName.login:
        return (context) => const LoginPage();
      case RoutesName.singUpOtpScreen:
        return (context) => const FillTheOtp();
        case RoutesName.register:
        return (context) => const SignUp();
        case RoutesName.bottomPage:
        return (context) => const HealthCradButton();
        case RoutesName.reqDocsVerification:
        return (context) => const ReqDocsVerification();
        case RoutesName.noInternet:
        return (context) => const NoInternet();

      default:
        return (context) => const Scaffold(
              body: Center(
                child: Text(
                  'No Route Found!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            );
    }
  }
}
