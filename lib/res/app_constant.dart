import 'package:flutter/material.dart';

import '../main.dart';

class AppConstant {
  static  String appName = "Veronova Doctor";

  static double get fontSizeZero =>
      width < 500 ? width / 40 : width / 50;
  static double get fontSizeOne =>
      width < 500 ? width / 35 : width / 45;
  static double get fontSizeTwo =>
      width < 500 ? width / 28 : width / 38;
  static double get fontSizeThree =>
      width < 500 ? width / 23 : width / 33;
  static double get fontSizeLarge =>
      width < 500 ? width / 18 : width / 28;
  static double get fontSizeHeading =>
      width < 500 ? width / 13 : 23;



  static const spaceWidth5 = SizedBox(width: 5);
  static const spaceWidth10 = SizedBox(width: 10);
  static const spaceWidth15 = SizedBox(width: 15);
  static const spaceWidth20 = SizedBox(width: 20);
  static const spaceWidth25 = SizedBox(width: 25);

  static const spaceHeight5 = SizedBox(height: 5);
  static const spaceHeight10 = SizedBox(height: 10);
  static const spaceHeight15 = SizedBox(height: 15);
  static const spaceHeight20 = SizedBox(height: 20);
  static const spaceHeight25 = SizedBox(height: 25);
  static const spaceHeight30 = SizedBox(height: 30);
  static const spaceHeight50 = SizedBox(height: 50);
  static const spaceHeight180 = SizedBox(height: 180);




}