import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/profile_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../model/doc_cat_model.dart';

class TokenRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> tokenApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.tokenApi,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during tokenApi: $e');
      }
      rethrow;
    }
  }


}