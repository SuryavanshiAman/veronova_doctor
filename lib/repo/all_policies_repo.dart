import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class AllPoliciesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> allPoliciesApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(ApiUrl.policies,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during allPoliciesApi: $e');
      }
      rethrow;
    }
  }
}