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
  dynamic updatedAt;
  dynamic name;
  dynamic mobile;
  dynamic email;
  dynamic expertsId;
  dynamic slotsId;
  dynamic weekDay;
  dynamic patientAge;
  dynamic patientImage;
  dynamic patientGender;
  dynamic doctorFees;

  Data(
      {this.id,
        this.docId,
        this.userId,
        this.status,
        this.updatedAt,
        this.name,
        this.mobile,
        this.email,
        this.expertsId,
        this.slotsId,
        this.weekDay,
        this.patientAge,
        this.patientImage,
        this.patientGender,
        this.doctorFees});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docId = json['doc_id'];
    userId = json['user_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    expertsId = json['experts_id'];
    slotsId = json['slots_id'];
    weekDay = json['week_day'];
    patientAge = json['patient_age'];
    patientImage = json['patient_image'];
    patientGender = json['patient_gender'];
    doctorFees = json['doctor_fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doc_id'] = docId;
    data['user_id'] = userId;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['experts_id'] = expertsId;
    data['slots_id'] = slotsId;
    data['week_day'] = weekDay;
    data['patient_age'] = patientAge;
    data['patient_image'] = patientImage;
    data['patient_gender'] = patientGender;
    data['doctor_fees'] = doctorFees;
    return data;
  }
}
