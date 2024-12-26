// class SlotHistoryModel {
//   SlotHistoryData? slotHistoryData;
//   int? status;
//   String? message;
//
//   SlotHistoryModel({this.slotHistoryData, this.status, this.message});
//
//   SlotHistoryModel.fromJson(Map<String, dynamic> json) {
//     slotHistoryData =
//         json['data'] != null ? SlotHistoryData.fromJson(json['data']) : null;
//     status = json['status'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (slotHistoryData != null) {
//       data['data'] = slotHistoryData!.toJson();
//     }
//     data['status'] = status;
//     data['message'] = message;
//     return data;
//   }
// }
//
// class SlotHistoryData {
//   int? id;
//   int? doctorId;
//   int? slotType;
//   String? weekDay;
//   String? createdAt;
//   String? updatedAt;
//   List<Slotdata>? slotdata;
//
//   SlotHistoryData(
//       {this.id,
//       this.doctorId,
//       this.slotType,
//       this.weekDay,
//       this.createdAt,
//       this.updatedAt,
//       this.slotdata});
//
//   SlotHistoryData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     doctorId = json['doctor_id'];
//     slotType = json['slot_type'];
//     weekDay = json['week_day'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['slotdata'] != null) {
//       slotdata = <Slotdata>[];
//       json['slotdata'].forEach((v) {
//         slotdata!.add(Slotdata.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['doctor_id'] = doctorId;
//     data['slot_type'] = slotType;
//     data['week_day'] = weekDay;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (slotdata != null) {
//       data['slotdata'] = slotdata!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Slotdata {
//   int? id;
//   String? sTime;
//   String? eTime;
//   String? sDuration;
//   int? slotId;
//   int? slotNumber;
//   String? createdAt;
//   String? updatedAt;
//   int? slotType;
//   int? slot_total;
//
//   Slotdata(
//       {this.id,
//       this.sTime,
//       this.eTime,
//       this.sDuration,
//       this.slotId,
//       this.slotNumber,
//       this.createdAt,
//       this.updatedAt,
//       this.slotType,
//       this.slot_total,
//       });
//
//   Slotdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sTime = json['s_time'];
//     eTime = json['e_time'];
//     sDuration = json['s_duration'];
//     slotId = json['slot_id'];
//     slotNumber = json['slot_number'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     slotType = json['slot_type'];
//     slot_total = json['slot_total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['s_time'] = sTime;
//     data['e_time'] = eTime;
//     data['s_duration'] = sDuration;
//     data['slot_id'] = slotId;
//     data['slot_number'] = slotNumber;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['slot_type'] = slotType;
//     data['slot_total'] = slotType;
//     return data;
// //   }
// }


class SlotHistoryModel {
  SlotHistoryData? slotHistoryData;
  int? status;
  String? message;

  SlotHistoryModel({this.slotHistoryData, this.status, this.message});

  SlotHistoryModel.fromJson(Map<String, dynamic> json) {
    slotHistoryData = json['data'] != null ? SlotHistoryData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slotHistoryData != null) {
      data['data'] = slotHistoryData!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class SlotHistoryData {
  dynamic id;
  dynamic doctorId;
  dynamic slotType;
  String? weekDay;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic slotTotal;
  List<Slotdata>? slotdata;
  List<SData>? sdata; // New field for sdata list

  SlotHistoryData(
      {this.id,
        this.doctorId,
        this.slotType,
        this.weekDay,
        this.createdAt,
        this.updatedAt,
        this.slotTotal,
        this.slotdata,
        this.sdata});

  SlotHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    slotType = json['slot_type'];
    weekDay = json['week_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slotTotal = json['slot_total'];
    if (json['slotdata'] != null) {
      slotdata = <Slotdata>[];
      json['slotdata'].forEach((v) {
        slotdata!.add(Slotdata.fromJson(v));
      });
    }
    if (json['sdata'] != null) {
      sdata = <SData>[];
      json['sdata'].forEach((v) {
        sdata!.add(SData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['slot_type'] = slotType;
    data['week_day'] = weekDay;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['slot_total'] = slotTotal;
    if (slotdata != null) {
      data['slotdata'] = slotdata!.map((v) => v.toJson()).toList();
    }
    if (sdata != null) {
      data['sdata'] = sdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slotdata {
  dynamic id;
  dynamic sTime;
  dynamic eTime;
  dynamic sDuration;
  dynamic slotId;
  dynamic slotNumber;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic slotType;
  dynamic isDeleted;
  dynamic totalSlot;

  Slotdata(
      {this.id,
        this.sTime,
        this.eTime,
        this.sDuration,
        this.slotId,
        this.slotNumber,
        this.createdAt,
        this.updatedAt,
        this.slotType,
        this.isDeleted,
        this.totalSlot});

  Slotdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTime = json['s_time'];
    eTime = json['e_time'];
    sDuration = json['s_duration'];
    slotId = json['slot_id'];
    slotNumber = json['slot_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slotType = json['slot_type'];
    isDeleted = json['is_deleted'];
    totalSlot = json['total_slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['s_time'] = sTime;
    data['e_time'] = eTime;
    data['s_duration'] = sDuration;
    data['slot_id'] = slotId;
    data['slot_number'] = slotNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['slot_type'] = slotType;
    data['is_deleted'] = isDeleted;
    data['total_slot'] = totalSlot;
    return data;
  }
}

// New SData class to represent individual sdata items
class SData {
  String? sTime;

  SData({this.sTime});

  SData.fromJson(Map<String, dynamic> json) {
    sTime = json['s_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s_time'] = sTime;
    return data;
  }
}

// class SlotHistoryModel {
//   SlotHistoryData? slotHistoryData;
//   int? status;
//   String? message;
//
//   SlotHistoryModel({this.slotHistoryData, this.status, this.message});
//
//   SlotHistoryModel.fromJson(Map<String, dynamic> json) {
//     slotHistoryData = json['data'] != null ? SlotHistoryData.fromJson(json['data']) : null;
//     status = json['status'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (slotHistoryData != null) {
//       data['data'] = slotHistoryData!.toJson();
//     }
//     data['status'] = status;
//     data['message'] = message;
//     return data;
//   }
// }
//
// class SlotHistoryData {
//   dynamic id;
//   dynamic doctorId;
//   dynamic slotType;
//   String? weekDay;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic slotTotal;
//   List<Slotdata>? slotdata;
//
//   SlotHistoryData(
//       {this.id,
//         this.doctorId,
//         this.slotType,
//         this.weekDay,
//         this.createdAt,
//         this.updatedAt,
//         this.slotTotal,
//         this.slotdata});
//
//   SlotHistoryData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     doctorId = json['doctor_id'];
//     slotType = json['slot_type'];
//     weekDay = json['week_day'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     slotTotal = json['slot_total'];
//     if (json['slotdata'] != null) {
//       slotdata = <Slotdata>[];
//       json['slotdata'].forEach((v) {
//         slotdata!.add(Slotdata.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['doctor_id'] = doctorId;
//     data['slot_type'] = slotType;
//     data['week_day'] = weekDay;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['slot_total'] = slotTotal;
//     if (slotdata != null) {
//       data['slotdata'] = slotdata!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Slotdata {
//   dynamic id;
//   dynamic sTime;
//   dynamic eTime;
//   dynamic sDuration;
//   dynamic slotId;
//   dynamic slotNumber;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic slotType;
//   dynamic isDeleted;
//   dynamic totalSlot;
//
//   Slotdata(
//       {this.id,
//         this.sTime,
//         this.eTime,
//         this.sDuration,
//         this.slotId,
//         this.slotNumber,
//         this.createdAt,
//         this.updatedAt,
//         this.slotType,
//         this.isDeleted,
//         this.totalSlot});
//
//   Slotdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sTime = json['s_time'];
//     eTime = json['e_time'];
//     sDuration = json['s_duration'];
//     slotId = json['slot_id'];
//     slotNumber = json['slot_number'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     slotType = json['slot_type'];
//     isDeleted = json['is_deleted'];
//     totalSlot = json['total_slot'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['s_time'] = sTime;
//     data['e_time'] = eTime;
//     data['s_duration'] = sDuration;
//     data['slot_id'] = slotId;
//     data['slot_number'] = slotNumber;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['slot_type'] = slotType;
//     data['is_deleted'] = isDeleted;
//     data['total_slot'] = totalSlot;
//     return data;
//   }
// }
