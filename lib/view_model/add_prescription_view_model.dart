import 'dart:convert';

import 'package:doctor_apk/repo/add_prescription_repo.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddPrescriptionViewModel with ChangeNotifier {
  final _addPrescriptionRepo = AddPrescriptionRepo();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addPrescriptionApi(
      dynamic patientId,
      dynamic patientName,
      dynamic mobile,
      dynamic email,
      dynamic slotId,
      dynamic age,
      dynamic gender,
      dynamic appointmentId,
      dynamic symptoms,
      dynamic medicines,
      dynamic note,
      context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();

    Map data = {
      "user_id":patientId,
      "doc_id":userId,
      "name":patientName,
      "mobile":mobile,
      "email":email,
      "slots_id":slotId,
      "age":age,
      "gender":gender,
      "appointment_id":appointmentId,
      "symptoms":symptoms,
      "medicines":medicines,
      "note":note
    };

    print("addeddata ${data}");
    _addPrescriptionRepo.addPrescriptionApi(data).then((value) {
      if (value['status'] == "200") {
        setLoading(false);
        Utils.show("Prescription added successfully", context);
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
