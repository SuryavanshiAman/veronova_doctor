import 'package:doctor_apk/model/current_appointment_model.dart';
import 'package:doctor_apk/model/view_slot_model.dart';

import 'package:doctor_apk/repo/appointment_repo.dart';
import 'package:doctor_apk/repo/view_slot_repo.dart';

import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewSlotViewModel with ChangeNotifier {
  final _viewSlot = ViewSlotRepo();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ViewSlotModel? _viewSlotModel;
  ViewSlotModel? get viewSlotModelData =>
      _viewSlotModel;

  void setViewSlotModel(ViewSlotModel name) {
    _viewSlotModel = name;
    notifyListeners();
  }

  Future<void> viewSlot(context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print("hiieiei $userId");
    Map data={
      "doctor_id":userId
    };
    _viewSlot.viewSlot(data).then((value) {
      if (value.status == "200") {
        setViewSlotModel(value);
      } else {
        setViewSlotModel(value);
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
