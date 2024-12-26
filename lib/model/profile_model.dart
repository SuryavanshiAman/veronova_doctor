class ProfileModel {
  Data? data;
  int? status;
  String? message;

  ProfileModel({this.data, this.status, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  dynamic imgUrl;
  String? name;
  String? email;
  dynamic address;
  int? phone;
  String? qualification;
  dynamic department;
  String? profile;
  String? exp;
  int? fees;
  dynamic specialties;
  dynamic ionUserId;
  dynamic hospitalId;
  dynamic departmentName;
  dynamic appointmentConfirmation;
  dynamic signature;
  dynamic aadharFront;
  dynamic aadharBack;
  dynamic license;
  int? status;
  dynamic password;
  dynamic docstatus;
  dynamic city;
  dynamic state;
  dynamic landmark;
  int? otp;
  String? about;
  dynamic adminShow;
  dynamic review;
  dynamic regNumber;
  dynamic regYear;
  dynamic medicalCouncilName;
  dynamic gender;
  int? document;
  String? proofId;
  String? medicalDegree;
  String? accountName;
  String? accountNumber;
  String? ifscCode;

  Data(
      {this.id,
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
      this.specialties,
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
      this.state,
      this.landmark,
      this.otp,
      this.about,
      this.adminShow,
      this.review,
      this.regNumber,
      this.regYear,
      this.medicalCouncilName,
      this.gender,
      this.document,
      this.proofId,
      this.medicalDegree,
      this.accountName,
      this.accountNumber,
      this.ifscCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    specialties = json['specialties'];
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
    state = json['state'];
    landmark = json['landmark'];
    otp = json['otp'];
    about = json['about'];
    adminShow = json['admin_show'];
    review = json['review'];
    regNumber = json['reg_number'];
    regYear = json['reg_year'];
    medicalCouncilName = json['medical_council_name'];
    gender = json['gender'];
    document = json['document'];
    proofId = json['proof_id'];
    medicalDegree = json['medical_degree'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    data['specialties'] = specialties;
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
    data['state'] = state;
    data['landmark'] = landmark;
    data['otp'] = otp;
    data['about'] = about;
    data['admin_show'] = adminShow;
    data['review'] = review;
    data['reg_number'] = regNumber;
    data['reg_year'] = regYear;
    data['medical_council_name'] = medicalCouncilName;
    data['gender'] = gender;
    data['document'] = document;
    data['proof_id'] = proofId;
    data['medical_degree'] = medicalDegree;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;

    return data;
  }
}
