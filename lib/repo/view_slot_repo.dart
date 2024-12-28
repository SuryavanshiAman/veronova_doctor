import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/view_slot_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class ViewSlotRepo {

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ViewSlotModel> viewSlot(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.slotViewUrl, data);
      return ViewSlotModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during viewSlot: $e');
      }
      rethrow;
    }
  }





}