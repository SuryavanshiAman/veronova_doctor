import 'package:doctor_apk/model/view_bank_model.dart';
import 'package:doctor_apk/repo/view_bank_details.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewBankDetailViewModel with ChangeNotifier {
  final _viewBankDetailRepo = ViewBankDetailsRepository();
  BankModel? _bankDetailResponse;
  BankModel? get bankDetailResponse => _bankDetailResponse;

  setBankDetailsList(BankModel response) {
    _bankDetailResponse = response;
    notifyListeners();
  }

  Future<void> viewBankDetailsApi(BuildContext context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
Map data={
  "userid":userId
};
    _viewBankDetailRepo.viewBankDetailsApi(data).then((value) {
      if (value.status == "200") {
        setBankDetailsList(value);
      } else {
        if (kDebugMode) {
          print('value: ${value.msg}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
