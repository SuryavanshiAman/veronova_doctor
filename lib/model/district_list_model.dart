class CityListModel {
  int? status;
  String? message;
  List<CityData>? data;

  CityListModel({this.status, this.message, this.data});

  CityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(CityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityData {
  int? id;
  String? city;
  int? stateId;

  CityData({this.id, this.city, this.stateId});

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['state_id'] = stateId;
    return data;
  }
}
