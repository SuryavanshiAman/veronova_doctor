import 'package:doctor_apk/repo/auth_repo.dart';
import 'package:doctor_apk/repo/bank_repo.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BankViewModel with ChangeNotifier {
  final _bankRepo = BankRepo();

  // Bank Details

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> bankDetailsApi(
      dynamic accountNumberCon,
      dynamic accountNameCon,
      dynamic branch,
      dynamic ifscCode,
      context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data = {
      "doctor_id":userId,
      "account_no":accountNumberCon,
      "holder_name":accountNameCon,
      "branch_name":branch,
      "ifsc_code":ifscCode
    };
    _bankRepo.bankDetailsApi(data).then((value) {
      if (value['status'] == "200") {
        setLoading(false);
        Utils.show("Bank Details Update SuccessFully", context);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
