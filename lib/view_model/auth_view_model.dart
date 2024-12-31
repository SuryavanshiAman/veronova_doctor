import 'package:doctor_apk/repo/auth_repo.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  // Login Api

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic mobileCon, context) async {
    final userPref = Provider.of<UserViewModel>(context, listen: false);
    setLoading(true);
    Map data = {
      "mobile": mobileCon,
    };

    _authRepo.loginApi(data).then((value) {
      if (value['status'] == "200") {
        setLoading(false);
        userPref.saveUser(value['data']['id'].toString());
        Navigator.pushReplacementNamed(context, RoutesName.singUpOtpScreen,
            arguments: {'phone': mobileCon,"status": 0});
      } else if (value['status'] == "400") {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesName.register,
            arguments: {'phone': mobileCon});
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

// REGISTER API
  bool _loadingRegister = false;

  bool get loadingRegister => _loadingRegister;

  setLoadingRegister(bool value) {
    _loadingRegister = value;
    notifyListeners();
  }

  Future<void> registerApi(
      dynamic mobileCon,
      dynamic nameCon,
      dynamic emailCon,
      dynamic regNumber,
      dynamic regYear,
      dynamic medicalCouncilName,
      dynamic gender,
      // dynamic state, dynamic city,
      context) async {
    setLoadingRegister(true);
    final userPref = Provider.of<UserViewModel>(context, listen: false);
    Map data = {
      "phone": mobileCon,
      "name": nameCon,
      "email": emailCon,
      "reg_number": regNumber,
      "reg_year": regYear,
      "medical_council_name": medicalCouncilName,
      "gender": gender,
      // "state":state,
      // "city":city
    };
    print(data);
    _authRepo.registerApi(data).then((value) {
      if (value['status']== "200") {
        setLoadingRegister(false);
        print("USerID:${value['id']}");
        userPref.saveUser(value['id'].toString());
        Navigator.pushReplacementNamed(context, RoutesName.bottomPage,
            // arguments: {'phone': mobileCon,"status": 1}
        );
      }else{
        Utils.show(value["message"], context);
        setLoadingRegister(false);
      }
    }).onError((error, stackTrace) {
      setLoadingRegister(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

// SEND OTP

  bool _sendOtp = false;

  bool get sendOtp => _sendOtp;

  setSendOtp(bool value) {
    _sendOtp = value;
    notifyListeners();
  }

  Future<void> sendOtpApi(dynamic mobileCon, context) async {
    setSendOtp(true);
    Map data = {
      "phone": mobileCon,
    };
    _authRepo.sendOtpApi(data).then((value) {
      if (value['status'] == 200) {
        setSendOtp(false);
      }
    }).onError((error, stackTrace) {
      setSendOtp(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

// Verify OTP

  bool _verifyOtp = false;

  bool get verifyOtp => _verifyOtp;

  setVerifyOtp(bool value) {
    _verifyOtp = value;
    notifyListeners();
  }

  Future<void> verifyOtpApi(dynamic mobileCon, dynamic otpCon, context) async {
    setVerifyOtp(true);
    final userPref = Provider.of<UserViewModel>(context, listen: false);
    Map data = {
      "phone": mobileCon,
      "otp": otpCon,
    };
    print(data);
    _authRepo.verifyOtpApi(data).then((value) {
      if (value['status'] == 200) {
        userPref.saveUser(value['data']['id'].toString());
        setVerifyOtp(false);
        Navigator.pushNamed(context, RoutesName.bottomPage);
      } else {
        Utils.show("Please enter Valid Otp", context);
      }
    }).onError((error, stackTrace) {
      setLoadingRegister(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
