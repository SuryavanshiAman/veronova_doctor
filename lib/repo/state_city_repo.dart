import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/district_list_model.dart';
import 'package:doctor_apk/model/state_list_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';



class StateCityRepo {
  final BaseApiServices _apiServices = NetworkApiServices();


  // bank Details


  Future<StateListModel> getStateApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.getStateData);
      return StateListModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during state api: $e');
      }
      rethrow;
    }
  }


  Future<CityListModel> getDistrictApi(dynamic stateId) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.getDistrictData+stateId);
      return CityListModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during district api: $e');
      }
      rethrow;
    }
  }


}
