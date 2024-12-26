import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/profile_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../model/doc_cat_model.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ProfileModel> profileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.profileUrl + data);
      return ProfileModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during profileApi: $e');
      }
      rethrow;
    }
  }

  Future<DoctorDepartment> doctorCatApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.doctorCatUrl);
      return DoctorDepartment.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorCatApi: $e');
      }
      rethrow;
    }
  }


}