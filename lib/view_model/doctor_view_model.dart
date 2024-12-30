import 'package:doctor_apk/model/doctor_history_model.dart';
import 'package:doctor_apk/model/doctor_view_review_model.dart';
import 'package:doctor_apk/repo/doctor_repo.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoctorViewModel with ChangeNotifier {
  final _doctorRepo = DoctorRepo();

  // Doctor History

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  DoctorHistoryModel? _doctorHistoryModel;
  DoctorHistoryModel? get doctorHistoryModel => _doctorHistoryModel;

  void setDoctorHistoryModel(DoctorHistoryModel name) {
    _doctorHistoryModel = name;
    notifyListeners();
  }

  Future<void> doctorHistoryApi(dynamic filterId,dynamic status, context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data = {
      "doc_id":userId,
      "status":filterId,
    };
    print("=> $data");
    _doctorRepo.doctorHistoryApi(data).then((value) {
      if (value.status == "200") {
        setDoctorHistoryModel(value);
       // if (status == 1){
       //   Navigator.pop(context);
       // }
      } else {
        setDoctorHistoryModel(value);
        // setDoctorHistoryModel(DoctorHistoryModel(data: null, status: "400", msg: "not found"));
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

  // doctor Vr Api

  DoctorViewReviewModel? _doctorVRModel;
  DoctorViewReviewModel? get doctorVRModel => _doctorVRModel;

  void setDoctorViewReviewModel(DoctorViewReviewModel name) {
    _doctorVRModel = name;
    notifyListeners();
  }

  Future<void> doctorVRApi(
    context,
  ) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();

    _doctorRepo.doctorVRApi(userId).then((value) {
      if (value.status == 200) {
        setDoctorViewReviewModel(value);
      } else {
        setDoctorViewReviewModel(DoctorViewReviewModel(data: null, status: 400, message: value.message));
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
