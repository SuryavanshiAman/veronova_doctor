class CurrentAppointmentsModel {
  List<Data>? data;
  String? msg;
  String? status;

  CurrentAppointmentsModel({this.data, this.msg, this.status});

  CurrentAppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic docId;
  dynamic userId;
  dynamic status;
  dynamic meetingStatus;
  dynamic updatedAt;
  dynamic name;
  dynamic mobile;
  dynamic email;
  dynamic expertsId;
  dynamic slotsId;
  dynamic weekDay;
  dynamic description;
  dynamic date;
  dynamic patientAge;
  dynamic patientImage;
  dynamic patientGender;
  dynamic appointmentTime;
  dynamic doctorFees;
  dynamic meeting;

  Data(
      {this.id,
        this.docId,
        this.userId,
        this.status,
        this.meetingStatus,
        this.updatedAt,
        this.name,
        this.mobile,
        this.email,
        this.expertsId,
        this.slotsId,
        this.weekDay,
        this.description,
        this.date,
        this.patientAge,
        this.patientImage,
        this.patientGender,
        this.appointmentTime,
        this.doctorFees,
        this.meeting,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docId = json['doc_id'];
    userId = json['user_id'];
    status = json['status'];
    meetingStatus = json['status_meeting'];
    updatedAt = json['updated_at'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    expertsId = json['experts_id'];
    slotsId = json['slots_id'];
    weekDay = json['week_day'];
    description = json['description'];
    date = json['date'];
    patientAge = json['patient_age'];
    patientImage = json['patient_image'];
    patientGender = json['patient_gender'];
    appointmentTime = json['appointment_date'];
    doctorFees = json['doctor_fees'];
    meeting = json['meeting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doc_id'] = docId;
    data['user_id'] = userId;
    data['status'] = status;
    data['status_meeting'] = meetingStatus;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['experts_id'] = expertsId;
    data['slots_id'] = slotsId;
    data['week_day'] = weekDay;
    data['description'] = description;
    data['date'] = date;
    data['patient_age'] = patientAge;
    data['patient_image'] = patientImage;
    data['patient_gender'] = patientGender;
    data['appointment_date'] = appointmentTime;
    data['doctor_fees'] = doctorFees;
    data['meeting'] = meeting;
    return data;
  }
}
