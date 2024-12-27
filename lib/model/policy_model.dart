class PolicyModel {
  String? headings;
  String? data;
  String? msg;
  String? status;

  PolicyModel({this.headings, this.data, this.msg, this.status});

  PolicyModel.fromJson(Map<String, dynamic> json) {
    headings = json['headings'];
    data = json['data'];
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headings'] = this.headings;
    data['data'] = this.data;
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}
