import 'package:doctor_apk/model/slot_history_model.dart';
import 'package:doctor_apk/repo/slot_repo.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/slot_date.dart';

class SlotViewModel with ChangeNotifier {
  final _slotRepo = SlotRepo();

  // update slot
  List<Map<String, dynamic>> selectedSlotsData = [];

  List<Map<String, dynamic>> individualDaySchedule = [
    {
      "type_id": "1",
      "title": 'Morning Slot',
      "img": "assets/icon/morning.png",
      "imgTime": "assets/icon/time.png",
      "dateTime": DateTime.now(),
      "start_time": '08:30',
      "end_time": '11:00',
      "rightImg": 'assets/icon/right.png',
      "isChecked": false,
      "slotDuration": [
        {"duration": '10', "isSelect": false},
        {"duration": '15', "isSelect": false},
        {"duration": '20', "isSelect": false},
        {"duration": '25', "isSelect": false},
        {"duration": '30', "isSelect": false},
      ]
    },
    {
      "type_id": "2",
      "title": 'Afternoon Slot',
      "img": "assets/icon/afternoon.png",
      "imgTime": "assets/icon/time.png",
      "dateTime": DateTime.now(),
      "start_time": '13:00',
      "end_time": '15:00',
      "rightImg": 'assets/icon/right.png',
      "isChecked": false,
      "slotDuration": [
        {"duration": '10', "isSelect": false},
        {"duration": '15', "isSelect": false},
        {"duration": '20', "isSelect": false},
        {"duration": '25', "isSelect": false},
        {"duration": '30', "isSelect": false},
      ]
    },
    {
      "type_id": "3",
      "title": 'Evening Slot',
      "img": "assets/icon/evening.png",
      "imgTime": "assets/icon/time.png",
      "dateTime": DateTime.now(),
      "start_time": '16:30',
      "end_time": '18:00',
      "rightImg": 'assets/icon/right.png',
      "isChecked": false,
      "slotDuration": [
        {"duration": '10', "isSelect": false},
        {"duration": '15', "isSelect": false},
        {"duration": '20', "isSelect": false},
        {"duration": '25', "isSelect": false},
        {"duration": '30', "isSelect": false},
      ]
    },
    {
      "type_id": "4",
      "title": 'Night Slot',
      "img": "assets/icon/night.png",
      "imgTime": "assets/icon/time.png",
      "dateTime": DateTime.now(),
      "start_time": '19:00',
      "end_time": '21:30',
      "rightImg": 'assets/icon/right.png',
      "isChecked": false,
      "slotDuration": [
        {"duration": '10', "isSelect": false},
        {"duration": '15', "isSelect": false},
        {"duration": '20', "isSelect": false},
        {"duration": '25', "isSelect": false},
        {"duration": '30', "isSelect": false},
      ]
    },
  ];

  List weekend = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  bool _loading = false;
  bool _loadingView = false;
  int _selectedVal = 0;
  bool _loadSlotData = false;
  bool _loadingDs = false;
  List<DateTime> _nextDays = [];
  int _clickDate = 0;
  String _slotType = '';
  int _totalSlots = 0;
  String? data;
  SlotHistoryModel? _slotHistoryModel;
  SlotDateAndAvailabilityModel? _slotDateAvailability;

  bool get loading => _loading;
  bool get loadingView => _loadingView;
  int get selectedVal => _selectedVal;
  bool get loadSlotData => _loadSlotData;
  bool get loadingDs => _loadingDs;
  SlotHistoryModel? get slotHistoryModel => _slotHistoryModel;
  List<DateTime>? get nextDays => _nextDays;
  int get clickDate => _clickDate;
  String get slotType => _slotType;
  int get totalSlots => _totalSlots;
  SlotDateAndAvailabilityModel? get slotDateAvailability =>
      _slotDateAvailability;

  void addSelectedSlot({
    required String typeId,
    required String title,
    required String startTime,
    required String endTime,
    required String duration,
  }) {
    // Remove existing entry for same type to avoid duplicates
    selectedSlotsData.removeWhere((element) => element["type_id"] == typeId);

    selectedSlotsData.add({
      "type_id": typeId,
      "title": title,
      "start_time": startTime,
      "end_time": endTime,
      "duration": duration,
    });

    notifyListeners();
  }


  setSlotTypeTime(int i) {
    if (individualDaySchedule[i]["isChecked"]) {
      for (var data in individualDaySchedule[i]["slotDuration"]) {
        if (data["isSelect"] == true) {
          data["isSelect"] = false;
        } else {}
      }
    }

    individualDaySchedule[i]["isChecked"] =
        !individualDaySchedule[i]["isChecked"];
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setLoadingView(bool value) {
    _loadingView = value;
    notifyListeners();
  }

  setSelectedVal(int val) {
    _selectedVal = val;
    notifyListeners();
  }

  setSlotLoading(bool val) {
    _loadSlotData = val;
    notifyListeners();
  }

  setLoadingDs(bool value) {
    _loadingDs = value;
    notifyListeners();
  }

  stSlotAvailData(SlotDateAndAvailabilityModel data) {
    _slotDateAvailability = data;
    notifyListeners();
  }

  void setSlotHistoryModel(SlotHistoryModel name) {
    _slotHistoryModel = name;
    notifyListeners();
  }

  setClickedDay(int index, BuildContext context) {
    _clickDate = index;
    fetchDataAndSetDate(context);
    notifyListeners();
  }

  setSlotType(String slotType) {
    _slotType = slotType;
    clearClickedIndex();
    notifyListeners();
  }

  fetchNext15Days() {
    List<DateTime> dates = [];
    DateTime currentDate = DateTime.now();
    for (int i = 0; i <= 7; i++) {
      dates.add(currentDate.add(Duration(days: i)));
    }
    _nextDays = List.from(dates);
    notifyListeners();
  }

  fetchDataAndSetDate(context) async {
    slotViewApi(
        DateFormat.EEEE().format(_nextDays[clickDate]).toLowerCase(),
        DateFormat("yyyy-MM-dd").format(_nextDays[clickDate]).toLowerCase(),
        context);

    notifyListeners();
  }

  String formatTo24Hour(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }

  Future<void> selectTime(BuildContext context, int index, String key) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final DateTime selectedTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );

      String formattedTime = formatTo24Hour(selectedTime);

      individualDaySchedule[index][key] = formattedTime;

      if (kDebugMode) {
        print("Selected time: $formattedTime");
      }
    }
    notifyListeners();
  }

  Future<void> slotApi(context, dynamic dataCon) async {
    setLoading(true);
    _slotRepo.slotApi(dataCon).then((value) {
      if (value['status'] == "200") {
        setLoading(false);
        Utils.show(value['msg'], context);
        Navigator.pop(context);
      } else {
        setLoading(false);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  Future<void> slotViewApi(String day, String date, context) async {
    setSlotLoading(true);
    _totalSlots = 0;
    _slotHistoryModel = null;
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();

    final data = "$userId/$day/$_slotType/$date";
    _slotRepo.slotViewApi(data).then((value) {
      if (value.status.toString() == "200") {
        setSlotHistoryModel(value);
        calculateTotalSlots(context);
      } else {
        setSlotHistoryModel(SlotHistoryModel(
            slotHistoryData: SlotHistoryData(
                id: 0,
                doctorId: 0,
                weekDay: "none",
                createdAt: "2024-10-18 13:08:44",
                updatedAt: "2024-10-18 13:08:44",
                slotTotal: 0,
                slotdata: null),
            status: 400,
            message: "not found"));
      }
      setSlotLoading(false);
    }).onError((error, stackTrace) {
      setSlotLoading(false);
      if (kDebugMode) {
        print('error happened: $error');
      }
    });
  }

  Future<void> deleteSlotApi(
    dynamic slotId,
    context,
  ) async {
    debugPrint("hii delete executed");
    setLoadingDs(true);
    Map data = {"slot_type": _slotType, "id": slotId};
    debugPrint("deleteApi$data");

    _slotRepo.deleteSlotApi(data).then((value) {
      if (value['status'] == 200) {
        Utils.show(value["message"], context);
        getSlotDates(context);
        slotViewApi(
            DateFormat.EEEE().format(_nextDays[_clickDate]).toLowerCase(),
            DateFormat("yyyy-MM-dd").format(_nextDays[clickDate]).toLowerCase(),
            context);
        setLoadingDs(false);
        Navigator.pop(context);
      } else {
        if (kDebugMode) {
          print('value');
        }
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  clearClickedIndex() {
    for (var item in individualDaySchedule) {
      if (item["isChecked"] == true) {
        item["isChecked"] = false;
        for (var data in item['slotDuration']) {
          if (data["isSelect"] == true) {
            data["isSelect"] = false;
          }
        }
      }
      notifyListeners();
    }
    _clickDate = 0;
    notifyListeners();
  }

  void calculateTotalSlots(BuildContext context) {
    int total = 0;
    if (_slotHistoryModel != null &&
        _slotHistoryModel!.slotHistoryData != null) {
      final slotDataList = _slotHistoryModel!.slotHistoryData!.slotdata;
      if (slotDataList != null) {
        for (var slotData in slotDataList) {
          if (slotData.sTime != null &&
              slotData.eTime != null &&
              slotData.sDuration != null) {
            total += generateSlots(
                    slotData.sTime!, slotData.eTime!, slotData.sDuration!)
                .length;
          } else {
            debugPrint("Slot data has null values: $slotData");
          }
        }
      } else {
        debugPrint("Slot data list is null");
      }
    } else {
      debugPrint("_slotHistoryModel or slotHistoryData is null");
    }

    _totalSlots = total - _slotHistoryModel!.slotHistoryData!.sdata!.length;
    debugPrint("Total slots: $totalSlots");
    setSlotLoading(false);

    notifyListeners();
  }

  List<String> generateSlots(String sTime, String eTime, String sDuration) {
    final DateFormat inputFormat = DateFormat("HH:mm");
    final DateFormat outputFormat = DateFormat("hh:mm a");

    final DateTime startTime = inputFormat.parse(sTime);
    DateTime endTime = inputFormat.parse(eTime);

    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(const Duration(hours: 24));
    }

    final int slotDuration = int.parse(sDuration);
    final List<String> slots = [];

    DateTime currentTime = startTime;

    while (currentTime.isBefore(endTime) || currentTime == endTime) {
      slots.add(outputFormat.format(currentTime));
      currentTime = currentTime.add(Duration(minutes: slotDuration));
    }

    return slots;
  }

  Future<void> getSlotDates(context) async {
    final docId = await UserViewModel().getUser();
    final data = "$docId/$_slotType";
    _slotRepo.getSlotDates(data).then((value) {
      if (value.status == 200) {
        fetchDataAndSetDate(context);
        stSlotAvailData(value);
      } else {
        stSlotAvailData(value);
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
