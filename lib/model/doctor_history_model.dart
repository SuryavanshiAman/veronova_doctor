class DoctorHistoryModel {
  int? status;
  String? message;
  List<DoctorHistoryData>? doctorHistoryData;

  DoctorHistoryModel({this.status, this.message, this.doctorHistoryData});

  DoctorHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      doctorHistoryData = <DoctorHistoryData>[];
      json['data'].forEach((v) {
        doctorHistoryData!.add(DoctorHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.doctorHistoryData != null) {
      data['data'] = this.doctorHistoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorHistoryData {
  int? id;
  int? docterId;
  dynamic imgUrl;
  dynamic name;
  dynamic email;
  dynamic address;
  dynamic phone;
  dynamic qualification;
  dynamic department;
  dynamic profile;
  dynamic exp;
  dynamic fees;
  dynamic ionUserId;
  dynamic hospitalId;
  dynamic departmentName;
  dynamic appointmentConfirmation;
  dynamic signature;
  dynamic aadharFront;
  dynamic aadharBack;
  dynamic license;
  dynamic status;
  dynamic password;
  dynamic docstatus;
  dynamic city;
  dynamic landmark;
  dynamic otp;
  dynamic about;
  dynamic adminShow;
  dynamic review;
  dynamic regNumber;
  dynamic regYear;
  dynamic medicalCouncilName;
  dynamic gender;
  dynamic doctorId;
  dynamic slotId;
  dynamic userId;
  dynamic paymode;
  dynamic sTime;
  dynamic eTime;
  dynamic weekday;
  dynamic date;
  dynamic slot;
  dynamic doctorName;
  dynamic userName;
  dynamic amount;
  dynamic slotType;
  dynamic age;
  dynamic patientName;
  dynamic totalPayable;
  dynamic payable;

  DoctorHistoryData(
      {this.id,
        this.docterId,
        this.imgUrl,
        this.name,
        this.email,
        this.address,
        this.phone,
        this.qualification,
        this.department,
        this.profile,
        this.exp,
        this.fees,
        this.ionUserId,
        this.hospitalId,
        this.departmentName,
        this.appointmentConfirmation,
        this.signature,
        this.aadharFront,
        this.aadharBack,
        this.license,
        this.status,
        this.password,
        this.docstatus,
        this.city,
        this.landmark,
        this.otp,
        this.about,
        this.adminShow,
        this.review,
        this.regNumber,
        this.regYear,
        this.medicalCouncilName,
        this.gender,
        this.doctorId,
        this.slotId,
        this.userId,
        this.paymode,
        this.sTime,
        this.eTime,
        this.weekday,
        this.date,
        this.slot,
        this.doctorName,
        this.userName,
        this.amount,
        this.slotType,
        this.age,
        this.patientName,
        this.totalPayable,
        this.payable});

  DoctorHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docterId = json['docter_id'];
    imgUrl = json['img_url'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    qualification = json['Qualification'];
    department = json['department'];
    profile = json['profile'];
    exp = json['Exp'];
    fees = json['fees'];
    ionUserId = json['ion_user_id'];
    hospitalId = json['hospital_id'];
    departmentName = json['department_name'];
    appointmentConfirmation = json['appointment_confirmation'];
    signature = json['signature'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    license = json['license'];
    status = json['status'];
    password = json['password'];
    docstatus = json['docstatus'];
    city = json['city'];
    landmark = json['landmark'];
    otp = json['otp'];
    about = json['about'];
    adminShow = json['admin_show'];
    review = json['review'];
    regNumber = json['reg_number'];
    regYear = json['reg_year'];
    medicalCouncilName = json['medical_council_name'];
    gender = json['gender'];
    doctorId = json['doctor_id'];
    slotId = json['slot_id'];
    userId = json['user_id'];
    paymode = json['paymode'];
    sTime = json['s_time'];
    eTime = json['e_time'];
    weekday = json['weekday'];
    date = json['date'];
    slot = json['slot'];
    doctorName = json['doctor_name'];
    userName = json['user_name'];
    amount = json['amount'];
    slotType = json['slot_type'];
    age = json['age'];
    patientName = json['patient_name'];
    totalPayable = json['total_payable'];
    payable = json['payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['docter_id'] = docterId;
    data['img_url'] = imgUrl;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['Qualification'] = qualification;
    data['department'] = department;
    data['profile'] = profile;
    data['Exp'] = exp;
    data['fees'] = fees;
    data['ion_user_id'] = ionUserId;
    data['hospital_id'] = hospitalId;
    data['department_name'] = departmentName;
    data['appointment_confirmation'] = appointmentConfirmation;
    data['signature'] = signature;
    data['aadhar_front'] = aadharFront;
    data['aadhar_back'] = aadharBack;
    data['license'] = license;
    data['status'] = status;
    data['password'] = password;
    data['docstatus'] = docstatus;
    data['city'] = city;
    data['landmark'] = landmark;
    data['otp'] = otp;
    data['about'] = about;
    data['admin_show'] = adminShow;
    data['review'] = review;
    data['reg_number'] = regNumber;
    data['reg_year'] = regYear;
    data['medical_council_name'] = medicalCouncilName;
    data['gender'] = gender;
    data['doctor_id'] = doctorId;
    data['slot_id'] = slotId;
    data['user_id'] = userId;
    data['paymode'] = paymode;
    data['s_time'] = sTime;
    data['e_time'] = eTime;
    data['weekday'] = weekday;
    data['date'] = date;
    data['slot'] = slot;
    data['doctor_name'] = doctorName;
    data['user_name'] = userName;
    data['amount'] = amount;
    data['slot_type'] = slotType;
    data['age'] = age;
    data['patient_name'] = patientName;
    data['total_payable'] = totalPayable;
    data['payable'] = payable;
    return data;
  }
}
