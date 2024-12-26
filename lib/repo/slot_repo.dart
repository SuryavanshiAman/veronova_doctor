import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/slot_history_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../model/slot_date.dart';

class SlotRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  // update slot

  Future<dynamic> slotApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.slotUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during slotApi: $e');
      }
      rethrow;
    }
  }

// Slot History

  Future<SlotHistoryModel> slotViewApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(ApiUrl.slotViewUrl + data);
      return SlotHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during slotViewApi: $e');
      }
      rethrow;
    }
  }



  // delete Slot

  Future<dynamic> deleteSlotApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.slotDeleteUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during deleteSlotApi: $e');
      }
      rethrow;
    }
  }

  Future<SlotDateAndAvailabilityModel> getSlotDates(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.getSlotDates+ data);
      return SlotDateAndAvailabilityModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during statusUpdateApi: $e');
      }
      rethrow;
    }
  }
}
