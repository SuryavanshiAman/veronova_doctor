import 'package:doctor_apk/model/current_appointment_model.dart';

import 'package:doctor_apk/repo/appointment_repo.dart';

import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppointmentViewModel with ChangeNotifier {
  final _appointmentRepo = AppointmentRepo();

  // Current Appointment

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  CurrentAppointmentsModel? _currentAppointmentsModel;
  CurrentAppointmentsModel? get currentAppointmentsModel =>
      _currentAppointmentsModel;

  void setCurrentAppointmentsModel(CurrentAppointmentsModel name) {
    _currentAppointmentsModel = name;
    notifyListeners();
  }

  Future<void> currentAppointmentApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print("hiieiei $userId");
    _appointmentRepo.currentAppointmentApi(userId).then((value) {
      if (value.status == 200) {
        setCurrentAppointmentsModel(value);
      } else {
        setCurrentAppointmentsModel(value);
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
