import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';



class DocumentVerifyRepo {
  final BaseApiServices _apiServices = NetworkApiServices();



  // Document Verify Repo

  Future<dynamic> documentVerifyApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.documentVerifyUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during documentVerifyApi: $e');
      }
      rethrow;
    }
  }


  // update  Status



  Future<dynamic> updateStatusApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.updateStatusUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during updateStatusApi: $e');
      }
      rethrow;
    }
  }


//    Update Status Approval


  Future<dynamic> statusUpdateApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.statusUpdateUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during statusUpdateApi: $e');
      }
      rethrow;
    }
  }



}
