class ViewSlotModel {
  List<Data>? data;
  String? msg;
  String? status;

  ViewSlotModel({this.data, this.msg, this.status});

  ViewSlotModel.fromJson(Map<String, dynamic> json) {
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
  dynamic doctorId;
 dynamic weekDay;
 dynamic date;
 dynamic status;
 dynamic updatedAt;
 dynamic name;
 dynamic mobile;

  Data(
      {this.id,
        this.doctorId,
        this.weekDay,
        this.date,
        this.status,
        this.updatedAt,
        this.name,
        this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    weekDay = json['week_day'];
    date = json['date'];
    status = json['status'];
    updatedAt = json['updated_at'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['week_day'] = weekDay;
    data['date'] = date;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
