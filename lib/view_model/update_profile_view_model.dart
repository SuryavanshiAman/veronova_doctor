import 'dart:convert';

import 'package:doctor_apk/repo/update_profile_repo.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'document_verify_view_model.dart';
import 'profile_view_model.dart';

class UpdateProfileViewModel with ChangeNotifier {
  final _updateProfileRepo = UpdateProfileRepo();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> updateProfileApi(
      dynamic nameCon,
      dynamic emailCon,
      dynamic qualificationNumber,
      dynamic expCon,
      dynamic feeCon,
      dynamic specialties,
      dynamic about,
      context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
print("Aman:$specialties");
    final documentVerifyViewModel =
        Provider.of<DocumentVerifyViewModel>(context, listen: false);

    Map data = {
      "userid": userId,
      "name": nameCon,
      "email": emailCon,
      "Qualification": qualificationNumber,
      "Exp": expCon,
      "fees": feeCon,
    "profile":"Male",
      "specialties": specialties.toString(),
      "about": about,
      "profile_pic":base64Decode(documentVerifyViewModel.idProfileImage!)
    };

    print("data ${data}");
    _updateProfileRepo.updateProfileApi(data).then((value) {
      if (value['status'] == "200") {
        setLoading(false);

        final profileViewModel =
            Provider.of<ProfileViewModel>(context, listen: false);
        profileViewModel.profileApi(context);
        Utils.show("Profile Update Successfully", context);
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
