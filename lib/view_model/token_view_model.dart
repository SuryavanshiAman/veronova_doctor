import 'package:doctor_apk/model/profile_model.dart';
import 'package:doctor_apk/model/show_prescription_model.dart';
import 'package:doctor_apk/model/token_model.dart';
import 'package:doctor_apk/repo/profile_repo.dart';
import 'package:doctor_apk/repo/show_priscription_repo.dart';
import 'package:doctor_apk/repo/token_repo.dart';
import 'package:doctor_apk/view/video_call/video_call_screen.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/doc_cat_model.dart';
import '../utils/utils.dart';


class TokenViewModel with ChangeNotifier {
  final _tokenRepo = TokenRepo();

  TokenModel? _modelData;
  TokenModel? get modelData => _modelData;

  void setModelData(TokenModel value) {
    _modelData = value;
    notifyListeners();
  }

  Future<void> tokenApi( context, dynamic channel,dynamic slotId, dynamic appointId,dynamic patientId) async {
    try {
      UserViewModel userViewModel = UserViewModel();
      String? userId = await userViewModel.getUser();
      print("User ID: $userId");

      Map<String, dynamic> data = {
      "channelName": channel,
      "uid": "0",
      "slots_id":slotId,
    "doctor_id":userId,
    "appointment_id":appointId,
    "userid":patientId
      };

      final response = await _tokenRepo.tokenApi(data);

      // if (response['status'] == 200) {
        TokenModel tokenModel = TokenModel.fromJson(response);
        Provider.of<TokenViewModel>(context, listen: false).setModelData(tokenModel);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoCallPage(
              channelName: modelData?.channelName??"", // unique per session
            ),
          ),
        );
      // } else {
      //   // Clear or handle error
      //   _modelData = null;
      //   notifyListeners();
      //   if (kDebugMode) {
      //     print('Error: ${response['msg']}');
      //   }
      // }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Exception: $error');
      }
    }
  }
}
