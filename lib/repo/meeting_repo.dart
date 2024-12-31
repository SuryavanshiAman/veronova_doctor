import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class MeetingRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> meetingApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.meeting, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during meetingApi: $e');
      }
      rethrow;
    }
  }
}
