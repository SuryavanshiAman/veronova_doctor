class DoctorViewReviewModel {
  Data? data;
  List<DoctorReview>? doctorReview;
  int? status;
  String? message;

  DoctorViewReviewModel(
      {this.data, this.doctorReview, this.status, this.message});

  DoctorViewReviewModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['doctor_review'] != null) {
      doctorReview = <DoctorReview>[];
      json['doctor_review'].forEach((v) {
        doctorReview!.add(DoctorReview.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (doctorReview != null) {
      data['doctor_review'] =
          doctorReview!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  dynamic docterId;
  dynamic imgUrl;
  dynamic name;
  dynamic email;
  dynamic address;
  int? phone;
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

  Data(
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
        this.review});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class DoctorReview {
  int? id;
  String? userName;
  int? type;
  int? userId;
  int? rating;
  String? message;
  int? status;
  Null dateTime;

  DoctorReview(
      {this.id,
        this.userName,
        this.type,
        this.userId,
        this.rating,
        this.message,
        this.status,
        this.dateTime});

  DoctorReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    type = json['type'];
    userId = json['user_id'];
    rating = json['rating'];
    message = json['message'];
    status = json['status'];
    dateTime = json['date&time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['type'] = type;
    data['user_id'] = userId;
    data['rating'] = rating;
    data['message'] = message;
    data['status'] = status;
    data['date&time'] = dateTime;
    return data;
  }
}
