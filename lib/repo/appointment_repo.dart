import 'package:doctor_apk/helper/network/base_api_services.dart';
import 'package:doctor_apk/helper/network/network_api_services.dart';
import 'package:doctor_apk/model/current_appointment_model.dart';
import 'package:doctor_apk/model/doctor_history_model.dart';
import 'package:doctor_apk/model/doctor_view_review_model.dart';
import 'package:doctor_apk/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class AppointmentRepo {


  final BaseApiServices _apiServices = NetworkApiServices();

// Appointment Api

  Future<CurrentAppointmentsModel> currentAppointmentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.currentAppointmentUrl + data);
      return CurrentAppointmentsModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during currentAppointmentApi: $e');
      }
      rethrow;
    }
  }





}