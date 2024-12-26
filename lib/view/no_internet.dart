import 'package:doctor_apk/generated/assets.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

double width = 0.0;
double height = 0.0;

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.3,
              width: width * 0.5,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(Assets.imgNoInternet))),
            ),
            TextContext(
                data: 'There is no Internet connection (:'.toUpperCase()),
            TextContext(
                data: 'Please check your Internet connection'),
            SizedBox(height: 30,),
            CircularProgressIndicator(color: ColorConstant.primaryColor,)
          ],
        ),
      ),
    );
  }
}
