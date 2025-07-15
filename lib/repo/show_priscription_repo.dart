import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/profile_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../model/doc_cat_model.dart';

class ShowPrescriptionRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> showPrescriptionApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.showPrescription,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during showPrescription: $e');
      }
      rethrow;
    }
  }


}