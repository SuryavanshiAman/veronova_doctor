class ProfileModel {
  Data? data;
  String? msg;
  String? status;

  ProfileModel({this.data, this.msg, this.status});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  dynamic name;
  dynamic mobile;
  dynamic password;
  dynamic email;
  dynamic gender;
  dynamic otp;
  dynamic dob;
  dynamic age;
  dynamic image;
  dynamic wallet;
  dynamic status;
  dynamic isVerify;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic roleid;
  dynamic amount;
  dynamic regNumber;
  dynamic regYear;
  dynamic medicalCouncilName;
  dynamic proofId;
  dynamic medicalDegree;
  dynamic qualification;
  dynamic exp;
  dynamic specialties;
  dynamic about;
  dynamic fees;
  dynamic therapyId;
  dynamic documentstatus;
  dynamic profession;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.password,
        this.email,
        this.gender,
        this.otp,
        this.dob,
        this.age,
        this.image,
        this.wallet,
        this.status,
        this.isVerify,
        this.createdAt,
        this.updatedAt,
        this.roleid,
        this.amount,
        this.regNumber,
        this.regYear,
        this.medicalCouncilName,
        this.proofId,
        this.medicalDegree,
        this.qualification,
        this.exp,
        this.specialties,
        this.about,
        this.fees,
        this.therapyId,
        this.documentstatus,
        this.profession,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    password = json['password'];
    email = json['email'];
    gender = json['gender'];
    otp = json['otp'];
    dob = json['dob'];
    age = json['age'];
    image = json['image'];
    wallet = json['wallet'];
    status = json['status'];
    isVerify = json['is_verify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roleid = json['roleid'];
    amount = json['amount'];
    regNumber = json['reg_number'];
    regYear = json['reg_year'];
    medicalCouncilName = json['medical_council_name'];
    proofId = json['proof_id'];
    medicalDegree = json['medical_degree'];
    qualification = json['Qualification'];
    exp = json['Exp'];
    specialties = json['specialties'];
    about = json['about'];
    fees = json['fees'];
    therapyId = json['therapy_id'];
    documentstatus = json['documentstatus'];
    profession = json['profession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['password'] = password;
    data['email'] = email;
    data['gender'] = gender;
    data['otp'] = otp;
    data['dob'] = dob;
    data['age'] = age;
    data['image'] = image;
    data['wallet'] = wallet;
    data['status'] = status;
    data['is_verify'] = isVerify;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['roleid'] = roleid;
    data['amount'] = amount;
    data['reg_number'] = regNumber;
    data['reg_year'] = regYear;
    data['medical_council_name'] = medicalCouncilName;
    data['proof_id'] = proofId;
    data['medical_degree'] = medicalDegree;
    data['Qualification'] = qualification;
    data['Exp'] = exp;
    data['specialties'] = specialties;
    data['about'] = about;
    data['fees'] = fees;
    data['therapy_id'] = therapyId;
    data['documentstatus'] = documentstatus;
    data['profession'] = profession;
    return data;
  }
}
