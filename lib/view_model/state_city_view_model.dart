import 'package:doctor_apk/model/district_list_model.dart';
import 'package:doctor_apk/model/state_list_model.dart';
import 'package:doctor_apk/repo/state_city_repo.dart';
import 'package:flutter/foundation.dart';


class StateCityViewModel extends ChangeNotifier {
  final _stateCityRepo = StateCityRepo();

  StateListModel ? _stateListModel;
  CityListModel ? _districtListModelModel;
  StateListModel ? get stateListModel =>_stateListModel;
  CityListModel ? get districtListModel =>_districtListModelModel;


  setStateData(StateListModel data){
    _stateListModel = data;
    notifyListeners();
  }
  setDistrictData(CityListModel data){
    _districtListModelModel = data;
    notifyListeners();
  }
  Future<void> getStateApi() async {
    _stateCityRepo.getStateApi().then((value) {
      if (value.status == 200) {
        setStateData(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  Future<void> getDistrictApi(String stateId) async {
    _stateCityRepo.getDistrictApi(stateId).then((value) {
      if (value.status == 200) {
        setDistrictData(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
