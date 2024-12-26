import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/doctor_history_model.dart';
import 'package:doctor_apk/model/doctor_view_review_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorRepo {


  final BaseApiServices _apiServices = NetworkApiServices();

// Doctor History

  Future<DoctorHistoryModel> doctorHistoryApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.doctorHistoryUrl ,data);
      return DoctorHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorHistoryApi: $e');
      }
      rethrow;
    }
  }


//   Doctor View Review Api


  Future<DoctorViewReviewModel> doctorVRApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.doctorViewReviewUrl + data);
      return DoctorViewReviewModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorVRApi: $e');
      }
      rethrow;
    }
  }





}