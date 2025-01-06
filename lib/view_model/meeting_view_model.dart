
import 'package:doctor_apk/repo/meeting_repo.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/appointment_view_model.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetingViewModel with ChangeNotifier {
  final _meetingRepo = MeetingRepo();

  bool _loading = false;

  bool get loading => _loading;
int _meetingType=1;
int get meetingType=>_meetingType;
  int _selectedIndex=-1;
  int get selectedIndex=>_selectedIndex;
  setSelectedIndex(int value){
    _selectedIndex=value;
    notifyListeners();
  }

  final Set<int> _savedIndices = {};
  Set<int> get savedIndices => _savedIndices;
  void toggleSave(int value) {
    if (_savedIndices.contains(value)) {
      _savedIndices.remove(value);
    } else {
      _savedIndices.add(value);
    }
    notifyListeners();
  }
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> meetingApi(
      dynamic userId,
      dynamic appointmentId,
      dynamic link,
      // dynamic index,
      context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? docUserId = await userViewModel.getUser();

    Map data = {
      "doctor_id":docUserId,
      "user_id":userId,
      "appointment_id":appointmentId,
      "meeting":link,
      "status_meeting":"1"
    };

    print("data ${data}");
    _meetingRepo.meetingApi(data).then((value) {
      if (value['status'] == "200") {
        setLoading(false);
        // setMeeting(2,index);
        Utils.show("Meeting link send Successfully", context);
        Provider.of<AppointmentViewModel>(context, listen: false).currentAppointmentApi(context);
Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
