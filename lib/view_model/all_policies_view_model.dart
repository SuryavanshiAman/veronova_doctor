import 'package:doctor_apk/model/faq_model.dart';
import 'package:doctor_apk/model/policy_model.dart';
import 'package:doctor_apk/repo/all_policies_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPoliciesViewModel with ChangeNotifier {
  final _allPoliciesRepo = AllPoliciesRepository();
  PolicyModel? _policiesResponse;
  PolicyModel? get policiesResponse => _policiesResponse;
  setAllPoliciesData(PolicyModel response) {
    _policiesResponse = response;
    notifyListeners();
  }
  FaqModel? _faqResponse;
  FaqModel? get faqResponse => _faqResponse;
  setFaqData(FaqModel response) {
    _faqResponse = response;
    notifyListeners();
  }

  Future<void> allPoliciesApi(BuildContext context,dynamic type) async {
    Map data={
      "type":type
    };
    _allPoliciesRepo.allPoliciesApi(data).then((value) {
      if (value['status'] == "200") {
        PolicyModel allPoliciesModel = PolicyModel.fromJson(value);
        Provider.of<AllPoliciesViewModel>(context, listen: false).setAllPoliciesData(allPoliciesModel);
        FaqModel faqModel = FaqModel.fromJson(value);
        Provider.of<AllPoliciesViewModel>(context, listen: false).setFaqData(faqModel);
      } else {
        if (kDebugMode) {
          print('value: ${value['msg']}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
