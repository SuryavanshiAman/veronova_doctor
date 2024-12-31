class BankModel {
  Data? data;
  String? msg;
  String? status;

  BankModel({this.data, this.msg, this.status});

  BankModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? accountNo;
  String? holderName;
  String? ifscCode;
  String? branchName;

  Data(
      {this.id,
        this.accountNo,
        this.holderName,
        this.ifscCode,
        this.branchName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    ifscCode = json['ifsc_code'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['account_no'] = accountNo;
    data['holder_name'] = holderName;
    data['ifsc_code'] = ifscCode;
    data['branch_name'] = branchName;
    return data;
  }
}
