class ShowPrescriptionModel {
  Data? data;
  String? msg;
  int? status;

  ShowPrescriptionModel({this.data, this.msg, this.status});

  ShowPrescriptionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic pratientName;
  dynamic docName;
  dynamic Qualification;
  dynamic regNo;
  dynamic image;
  dynamic age;
  dynamic gender;
  dynamic time;
  dynamic pratientId;
  dynamic doctorId;
  dynamic appointmentId;
  dynamic status;
  dynamic slotsId;
  dynamic createdAt;
  dynamic symptoms;
  dynamic medicines;
  dynamic note;

  Data(
      {this.id,
        this.pratientName,
        this.docName,
        this.Qualification,
        this.regNo,
        this.image,
        this.age,
        this.gender,
        this.time,
        this.pratientId,
        this.doctorId,
        this.appointmentId,
        this.status,
        this.slotsId,
        this.createdAt,
        this.symptoms,
        this.medicines,
        this.note});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pratientName = json['pratient_name'];
    docName = json['docName'];
    Qualification = json['Qualification'];
    regNo = json['regNo'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    time = json['time'];
    pratientId = json['pratient_id'];
    doctorId = json['doctor_id'];
    appointmentId = json['appointment_id'];
    status = json['status'];
    slotsId = json['slots_id'];
    createdAt = json['created_at'];
    symptoms = json['symptoms'];
    medicines = json['medicines'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pratient_name'] = pratientName;
    data['docName'] = docName;
    data['Qualification'] = Qualification;
    data['regNo'] = regNo;
    data['image'] = image;
    data['age'] = age;
    data['gender'] = gender;
    data['time'] = time;
    data['pratient_id'] = pratientId;
    data['doctor_id'] = doctorId;
    data['appointment_id'] = appointmentId;
    data['status'] = status;
    data['slots_id'] = slotsId;
    data['created_at'] = createdAt;
    data['symptoms'] = symptoms;
    data['medicines'] = medicines;
    data['note'] = note;
    return data;
  }
}
