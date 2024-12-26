// ignore_for_file: use_build_context_synchronously

import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class SplashServices {
  Future<String?> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.toString());
        print('valueId');
      }
      if (value.toString() == 'null' || value.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.mainScreen);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.bottomPage);
        // Navigator.pushNamed(context, RoutesName.mapPage);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      });
    }
}
