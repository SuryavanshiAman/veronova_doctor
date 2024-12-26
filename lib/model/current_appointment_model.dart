class CurrentAppointmentsModel {
  int? status;
  String? message;
  List<CurrentAppointmentsData>? currentAppointmentsData;

  CurrentAppointmentsModel({this.status, this.message, this.currentAppointmentsData});

  CurrentAppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      currentAppointmentsData = <CurrentAppointmentsData>[];
      json['data'].forEach((v) {
        currentAppointmentsData!.add(CurrentAppointmentsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (currentAppointmentsData != null) {
      data['data'] = currentAppointmentsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentAppointmentsData {
  int? id;
  dynamic doctorId;
  dynamic slotId;
  dynamic userId;
  dynamic status;
  dynamic paymode;
  dynamic sTime;
  dynamic eTime;
  dynamic weekday;
  dynamic date;
  dynamic hospitalId;
  dynamic slot;
  dynamic doctorName;
  dynamic userName;
  dynamic amount;
  dynamic slotType;
  dynamic age;
  dynamic address;
  dynamic phone;
  dynamic patientName;
  dynamic totalPayable;
  dynamic payable;
  dynamic name;
  dynamic gender;
  dynamic fees;

  CurrentAppointmentsData(
      {this.id,
        this.doctorId,
        this.slotId,
        this.userId,
        this.status,
        this.paymode,
        this.sTime,
        this.eTime,
        this.weekday,
        this.date,
        this.hospitalId,
        this.slot,
        this.doctorName,
        this.userName,
        this.amount,
        this.slotType,
        this.age,
        this.address,
        this.phone,
        this.patientName,
        this.totalPayable,
        this.payable,
        this.name,
        this.gender,
        this.fees});

  CurrentAppointmentsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    slotId = json['slot_id'];
    userId = json['user_id'];
    status = json['status'];
    paymode = json['paymode'];
    sTime = json['s_time'];
    eTime = json['e_time'];
    weekday = json['weekday'];
    date = json['date'];
    hospitalId = json['hospital_id'];
    slot = json['slot'];
    doctorName = json['doctor_name'];
    userName = json['user_name'];
    amount = json['amount'];
    slotType = json['slot_type'];
    age = json['age'];
    address = json['address'];
    phone = json['phone'];
    patientName = json['patient_name'];
    totalPayable = json['total_payable'];
    payable = json['payable'];
    name = json['name'];
    gender = json['gender'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['slot_id'] = slotId;
    data['user_id'] = userId;
    data['status'] = status;
    data['paymode'] = paymode;
    data['s_time'] = sTime;
    data['e_time'] = eTime;
    data['weekday'] = weekday;
    data['date'] = date;
    data['hospital_id'] = hospitalId;
    data['slot'] = slot;
    data['doctor_name'] = doctorName;
    data['user_name'] = userName;
    data['amount'] = amount;
    data['slot_type'] = slotType;
    data['age'] = age;
    data['address'] = address;
    data['phone'] = phone;
    data['patient_name'] = patientName;
    data['total_payable'] = totalPayable;
    data['payable'] = payable;
    data['name'] = name;
    data['gender'] = gender;
    data['fees'] = fees;
    return data;
  }
}
