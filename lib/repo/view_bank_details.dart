import 'package:doctor_apk/model/view_bank_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class ViewBankDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<BankModel> viewBankDetailsApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(ApiUrl.viewBankDetails,data);
      return BankModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during viewBankDetailsApi: $e');
      }
      rethrow;
    }
  }
}