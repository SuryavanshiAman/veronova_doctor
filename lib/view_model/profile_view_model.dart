import 'package:doctor_apk/model/profile_model.dart';
import 'package:doctor_apk/repo/profile_repo.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../model/doc_cat_model.dart';
import '../utils/utils.dart';

class ProfileViewModel with ChangeNotifier {
  final _profileRepo = ProfileRepository();

  ProfileModel? _modelData;
  ProfileModel? get modelData => _modelData;

  void setModelData(ProfileModel value) {
    _modelData = value;
    notifyListeners();
  }

  Future<void> profileApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print(userId);
    Map data={
      "user_id":userId
    };
    _profileRepo.profileApi(data).then((value) {
      if (value['status'] == "200") {
        ProfileModel profileModel = ProfileModel.fromJson(value);
        Provider.of<ProfileViewModel>(context, listen: false).setModelData(profileModel);
      } else {
        setModelData(value);
        if (kDebugMode) {
          print('value: ${value['msg']}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
// Doctor Cat Api
  DoctorDepartment? _doctorModelData;

  DoctorDepartment? get doctorDepartmentModelData => _doctorModelData;

  setListData(DoctorDepartment value) {
    _doctorModelData = value;
    notifyListeners();
  }

  Future<void> doctorCatApi(context) async {
    _profileRepo.doctorCatApi().then((value) {
      if (value.status == "200") {
        setListData(value);
      } else {
        Utils.show(value.msg.toString(), context);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.show(error.toString(), context);
        print('error: $error');
      }
    });
  }
}
