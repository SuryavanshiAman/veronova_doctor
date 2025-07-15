import 'package:doctor_apk/model/profile_model.dart';
import 'package:doctor_apk/model/show_prescription_model.dart';
import 'package:doctor_apk/repo/profile_repo.dart';
import 'package:doctor_apk/repo/show_priscription_repo.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../model/doc_cat_model.dart';
import '../utils/utils.dart';

// class ShowPrescriptionViewModel  with ChangeNotifier {
//   final _showPrescriptionRepo = ShowPrescriptionRepo();
//
//   ShowPrescriptionModel? _modelData;
//   ShowPrescriptionModel? get modelData => _modelData;
//
//   void setModelData(ShowPrescriptionModel value) {
//     _modelData = value;
//     notifyListeners();
//   }
//
//   Future<void> showPrescriptionApi(context,dynamic id) async {
//     UserViewModel userViewModel = UserViewModel();
//     String? userId = await userViewModel.getUser();
//     print(userId);
//     Map data={
//       "appointment_id":id
//     };
//     _showPrescriptionRepo.showPrescriptionApi(data).then((value) {
//       if (value['status'] == "200") {
//         ShowPrescriptionModel showPrescriptionModel = ShowPrescriptionModel.fromJson(value);
//         Provider.of<ShowPrescriptionViewModel>(context, listen: false).setModelData(showPrescriptionModel);
//       } else {
//         setModelData(value);
//         if (kDebugMode) {
//           print('value: ${value['msg']}');
//         }
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print('error: $error');
//       }
//     });
//   }
//
// }
class ShowPrescriptionViewModel with ChangeNotifier {
  final _showPrescriptionRepo = ShowPrescriptionRepo();

  ShowPrescriptionModel? _modelData;
  ShowPrescriptionModel? get modelData => _modelData;

  void setModelData(ShowPrescriptionModel value) {
    _modelData = value;
    notifyListeners();
  }

  Future<void> showPrescriptionApi( context, dynamic id) async {
    try {
      UserViewModel userViewModel = UserViewModel();
      String? userId = await userViewModel.getUser();
      print("User ID: $userId");

      Map<String, dynamic> data = {
        "appointment_id": id,
      };

      final response = await _showPrescriptionRepo.showPrescriptionApi(data);

      if (response['status'] == 200) {
        ShowPrescriptionModel showPrescriptionModel = ShowPrescriptionModel.fromJson(response);
        Provider.of<ShowPrescriptionViewModel>(context, listen: false).setModelData(showPrescriptionModel);
      } else {
        // Clear or handle error
        _modelData = null;
        notifyListeners();
        if (kDebugMode) {
          print('Error: ${response['msg']}');
        }
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Exception: $error');
      }
    }
  }
}
