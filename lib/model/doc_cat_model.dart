class DoctorDepartment {
  List<Data>? data;
  String? msg;
  String? status;

  DoctorDepartment({this.data, this.msg, this.status});

  DoctorDepartment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? type;
  String? image;
  Null? updatedAt;
  String? status;

  Data(
      {this.id, this.name, this.type, this.image, this.updatedAt, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
