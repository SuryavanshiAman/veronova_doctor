import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';



class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
// Login Api
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.loginUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during loginApi: $e');
      }
      rethrow;
    }
  }


// Register Api
  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.registerUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during registerApi: $e');
      }
      rethrow;
    }
  }


// SendOtoApi

  Future<dynamic> sendOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.sendOtpUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during sendOtpApi: $e');
      }
      rethrow;
    }
  }

// verifyOtpApi

  Future<dynamic> verifyOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.verifyOtpUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during verifyOtpApi: $e');
      }
      rethrow;
    }
  }


}
